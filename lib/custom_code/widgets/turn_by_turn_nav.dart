/*// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Turn-by-turn in-app map using native Google Maps SDK via google_maps_flutter.
// Maintains the same public API:
//   TurnByTurnNav(apiKey, userLatLng, placeLatLng, ... width, height, useDeviceCompass)
// Supports Android/iOS (Web shows message as plugin does not support full navigation).

import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '/flutter_flow/lat_lng.dart' as ff;

class TurnByTurnNav extends StatefulWidget {
  const TurnByTurnNav({
    Key? key,
    required this.apiKey,
    required this.userLatLng, // pickup
    required this.placeLatLng, // destination
    this.userPhotoUrl,
    this.arrivalRadiusMeters = 25,
    this.simulateIfNoGPS = false,
    this.initialDriverLatLng,
    required this.width,
    required this.height,
    this.useDeviceCompass = true,
  }) : super(key: key);

  final String apiKey;
  final ff.LatLng userLatLng;
  final ff.LatLng placeLatLng;
  final String? userPhotoUrl;
  final double arrivalRadiusMeters;
  final bool simulateIfNoGPS;
  final ff.LatLng? initialDriverLatLng;
  final double width;
  final double height;
  final bool useDeviceCompass;

  @override
  State<TurnByTurnNav> createState() => _TurnByTurnNavState();
}

class _NavStep {
  _NavStep(
      {required this.start, required this.instruction, required this.distance});
  final gmaps.LatLng start;
  final String instruction;
  final double distance;
}

class _TurnByTurnNavState extends State<TurnByTurnNav> {
  gmaps.GoogleMapController? _map;
  StreamSubscription<Position>? _posSub;

  Set<gmaps.Polyline> _polylines = {};
  Set<gmaps.Marker> _markers = {};

  String _status = 'Inicializando...';
  String _etaText = '';
  double _remainingMeters = 0;

  bool _guidanceRunning = false;
  gmaps.LatLng? _currentLatLng;
  gmaps.LatLngBounds? _routeBounds;

  final FlutterTts _tts = FlutterTts();
  StreamSubscription<CompassEvent>? _compassSub;
  double _heading = 0;
  List<_NavStep> _steps = [];
  int _nextStep = 0;
  bool _is3D = true;
  static const String _darkMapStyle = '''[
  {"elementType": "geometry", "stylers": [{"color": "#242f3e"}]},
  {"elementType": "labels.text.fill", "stylers": [{"color": "#746855"}]},
  {"elementType": "labels.text.stroke", "stylers": [{"color": "#242f3e"}]},
  {"featureType": "road", "elementType": "geometry", "stylers": [{"color": "#38414e"}]},
  {"featureType": "road", "elementType": "geometry.stroke", "stylers": [{"color": "#212a37"}]},
  {"featureType": "road", "elementType": "labels.text.fill", "stylers": [{"color": "#9ca5b3"}]},
  {"featureType": "water", "elementType": "geometry", "stylers": [{"color": "#17263c"}]},
  {"featureType": "water", "elementType": "labels.text.fill", "stylers": [{"color": "#515c6d"}]}
]''';

  gmaps.BitmapDescriptor? _pickupIcon,
      _destIcon,
      _driverIcon; // Custom marker images
  gmaps.LatLng? _prevLatLng;
  DateTime _lastFsWrite = DateTime.fromMillisecondsSinceEpoch(0);

  gmaps.LatLng _toG(ff.LatLng v) =>
      gmaps.LatLng(v.latitude, v.longitude);

  Future<void> _loadIcons() async {
    try {
      _pickupIcon = await gmaps.BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(64, 64)),
          'assets/images/pickup_marker.png');
      _destIcon = await gmaps.BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(64, 64)),
          'assets/images/destination_marker.png');
      _driverIcon = await gmaps.BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(64, 64)),
          'assets/images/driver_marker.png');
    } catch (e) {
      debugPrint('Erro ao carregar ícones do mapa: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadIcons();
    if (kIsWeb) {
      _status = 'Navegação não suportada no Web.';
    }
    if (widget.useDeviceCompass) {
      _compassSub = FlutterCompass.events?.listen((event) {
        if (event.heading != null) {
          _heading = event.heading!;
          if (_guidanceRunning && _is3D && _currentLatLng != null) {
            _map?.animateCamera(gmaps.CameraUpdate.newCameraPosition(
                gmaps.CameraPosition(
                    target: _currentLatLng!,
                    zoom: 17,
                    tilt: 60,
                    bearing: _heading)));
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _posSub?.cancel();
    _compassSub?.cancel();
    _tts.stop();
    super.dispose();
  }

  Future<void> _loadRoute() async {
    final origin = widget.initialDriverLatLng ?? widget.userLatLng;
    final originStr = '${origin.latitude},${origin.longitude}';
    final destStr =
        '${widget.placeLatLng.latitude},${widget.placeLatLng.longitude}';
    var url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$originStr&destination=$destStr&key=${widget.apiKey}';
    if (widget.initialDriverLatLng != null) {
      final wp =
          '${widget.userLatLng.latitude},${widget.userLatLng.longitude}';
      url += '&waypoints=$wp';
    }

    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      setState(() => _status = 'Erro ao obter rota');
      return;
    }
    final data = json.decode(res.body);
    final routes = data['routes'] as List?;
    if (routes == null || routes.isEmpty) {
      setState(() => _status = 'Rota não encontrada');
      return;
    }

    final route = routes[0];
    final leg = (route['legs'] as List).first;
    final poly = route['overview_polyline']['points'] as String;
    _steps = (leg['steps'] as List)
        .map((s) => _NavStep(
            start: gmaps.LatLng(
                (s['start_location']['lat'] as num).toDouble(),
                (s['start_location']['lng'] as num).toDouble()),
            instruction: _stripHtml(s['html_instructions'] as String),
            distance: (s['distance']['value'] as num).toDouble()))
        .toList();

    final points = PolylinePoints().decodePolyline(poly);
    final polyCoords = points
        .map((e) => gmaps.LatLng(e.latitude, e.longitude))
        .toList();

    final polyline = gmaps.Polyline(
      polylineId: const gmaps.PolylineId('route'),
      color: const Color(0xFFFFC107),
      width: 6,
      points: polyCoords,
    );

    final pickupMarker = gmaps.Marker(
      markerId: const gmaps.MarkerId('pickup'),
      position: _toG(widget.userLatLng),
      icon: _pickupIcon ??
          gmaps.BitmapDescriptor.defaultMarkerWithHue(
              gmaps.BitmapDescriptor.hueGreen),
    );
    final destMarker = gmaps.Marker(
      markerId: const gmaps.MarkerId('dest'),
      position: _toG(widget.placeLatLng),
      icon: _destIcon ?? gmaps.BitmapDescriptor.defaultMarker,
    );

    _routeBounds = _boundsFrom(polyCoords);

    setState(() {
      _polylines = {polyline};
      _markers = {pickupMarker, destMarker};
      _etaText = leg['duration']['text'];
      _remainingMeters = (leg['distance']['value'] as num).toDouble();
      _status = 'Navegando...';
      _guidanceRunning = true;
    });

    await _map?.animateCamera(
        gmaps.CameraUpdate.newLatLngBounds(_routeBounds!, 50));

    _startLocationUpdates();
    _announceNextStep();
  }

  gmaps.LatLngBounds _boundsFrom(List<gmaps.LatLng> list) {
    double? x0, x1, y0, y1;
    for (final latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return gmaps.LatLngBounds(
        southwest: gmaps.LatLng(x0!, y0!), northeast: gmaps.LatLng(x1!, y1!));
  }

  void _startLocationUpdates() {
    _posSub?.cancel();
    _posSub = Geolocator.getPositionStream().listen((pos) {
      final newLatLng = gmaps.LatLng(pos.latitude, pos.longitude);
      if (!widget.useDeviceCompass && _prevLatLng != null) {
        _heading = Geolocator.bearingBetween(
            _prevLatLng!.latitude,
            _prevLatLng!.longitude,
            pos.latitude,
            pos.longitude);
      }
      _prevLatLng = newLatLng;
      _currentLatLng = newLatLng;

      final userMarker = gmaps.Marker(
        markerId: const gmaps.MarkerId('driver'),
        position: newLatLng,
        icon: _driverIcon ??
            gmaps.BitmapDescriptor.defaultMarkerWithHue(
                gmaps.BitmapDescriptor.hueAzure),
        rotation: _heading,
        anchor: const Offset(0.5, 0.5),
      );

      if (_guidanceRunning) {
        final cam = gmaps.CameraPosition(
            target: newLatLng,
            zoom: 17,
            tilt: _is3D ? 60 : 0,
            bearing: widget.useDeviceCompass ? _heading : _heading);
        _map?.animateCamera(gmaps.CameraUpdate.newCameraPosition(cam));
      }
      final dist = Geolocator.distanceBetween(pos.latitude, pos.longitude,
          widget.placeLatLng.latitude, widget.placeLatLng.longitude);
      if (_nextStep < _steps.length) {
        final step = _steps[_nextStep];
        final sDist = Geolocator.distanceBetween(pos.latitude, pos.longitude,
            step.start.latitude, step.start.longitude);
        if (sDist < 30) {
          _nextStep++;
          _announceNextStep();
        }
      }

      final updatedMarkers =
          _markers.where((m) => m.markerId != const gmaps.MarkerId('driver')).toSet();
      updatedMarkers.add(userMarker);

      final now = DateTime.now();
      if (now.difference(_lastFsWrite).inMilliseconds > 500) {
        _lastFsWrite = now;
        _sendLocationToFirestore(pos);
      }

      setState(() {
        _markers = updatedMarkers;
        _remainingMeters = dist;
        if (dist <= widget.arrivalRadiusMeters) {
          _status = 'Chegou ao destino. Corrida concluída.';
          _guidanceRunning = false;
        } else {
          _status = 'Navegando...';
        }
      });
    });
  }

  Future<void> _sendLocationToFirestore(Position pos) async {
    final uid = currentUserUid;
    // TODO: caso currentUserUid não esteja disponível, injete o uid via outra fonte.
    if (uid == null) return;
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'location': GeoPoint(pos.latitude, pos.longitude),
        'heading': _heading,
        'speed': pos.speed,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Erro ao atualizar localização no Firestore: $e');
    }
  }

  Future<void> _openGoogleNavigation() async {
    final origin = _currentLatLng ?? _toG(widget.userLatLng);
    final dest = _toG(widget.placeLatLng);
    final o = '${origin.latitude},${origin.longitude}';
    final d = '${dest.latitude},${dest.longitude}';
    final wp = '${widget.userLatLng.latitude},${widget.userLatLng.longitude}';

    if (Platform.isIOS) {
      // Attempt scheme if Google Maps app exists
      final scheme = Uri.parse('comgooglemaps://?saddr=$o&daddr=$d&directionsmode=driving');
      if (await canLaunchUrl(scheme)) {
        // comgooglemaps:// não aceita múltiplos waypoints oficialmente
        await launchUrl(scheme);
        return;
      }
      final gUrl = Uri.parse(
          'https://www.google.com/maps/dir/?api=1&origin=$o&destination=$d&travelmode=driving&dir_action=navigate&waypoints=$wp');
      if (await canLaunchUrl(gUrl)) {
        await launchUrl(gUrl, mode: LaunchMode.externalApplication);
        return;
      }
      final apple = Uri.parse('https://maps.apple.com/?saddr=$o&daddr=$d&dirflg=d');
      await launchUrl(apple, mode: LaunchMode.externalApplication);
    } else {
      final url = Uri.parse(
          'https://www.google.com/maps/dir/?api=1&origin=$o&destination=$d&travelmode=driving&dir_action=navigate&waypoints=$wp');
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _showRouteOverview() async {
    if (_routeBounds != null) {
      await _map?.animateCamera(
          gmaps.CameraUpdate.newLatLngBounds(_routeBounds!, 50));
    }
  }

  Future<void> _followMyLocation() async {
    if (_currentLatLng != null) {
      await _map?.animateCamera(gmaps.CameraUpdate.newCameraPosition(
          gmaps.CameraPosition(
              target: _currentLatLng!,
              zoom: 17,
              tilt: _is3D ? 60 : 0,
              bearing: widget.useDeviceCompass ? _heading : 0)));
    }
  }

  String _fmtKm(double meters) {
    if (meters < 1000) return '${meters.round()} m';
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  String _stripHtml(String html) => html.replaceAll(RegExp(r'<[^>]*>'), '');

  void _announceNextStep() {
    if (_nextStep >= _steps.length) return;
    final step = _steps[_nextStep];
    final dist = step.distance.round();
    _tts.setLanguage('pt-BR');
    _tts.speak('Em $dist metros, ${step.instruction}');
  }

  Future<void> _toggleView() async {
    _is3D = !_is3D;
    if (_currentLatLng != null) {
      final cam = gmaps.CameraPosition(
          target: _currentLatLng!,
          zoom: 17,
          tilt: _is3D ? 60 : 0,
          bearing: widget.useDeviceCompass ? _heading : 0);
      await _map?.animateCamera(gmaps.CameraUpdate.newCameraPosition(cam));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: kIsWeb
          ? _WebNotSupported(status: _status)
          : Stack(
              children: [
                gmaps.GoogleMap(
                  initialCameraPosition: gmaps.CameraPosition(
                      target: _toG(widget.userLatLng), zoom: 14),
                  onMapCreated: (controller) {
                    _map = controller;
                    controller.setMapStyle(_darkMapStyle);
                    _loadRoute();
                  },
                  myLocationEnabled: true,
                  markers: _markers,
                  polylines: _polylines,
                  compassEnabled: widget.useDeviceCompass,
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.70),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.route, color: Colors.white),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _guidanceRunning
                                ? '$_status • $_etaText • ${_fmtKm(_remainingMeters)}'
                                : _status,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        IconButton(
                          tooltip: 'Overview',
                          icon: const Icon(Icons.map_outlined,
                              color: Colors.white),
                          onPressed: _showRouteOverview,
                        ),
                        IconButton(
                          tooltip: 'Seguir meu local',
                          icon: const Icon(Icons.center_focus_strong,
                              color: Colors.white),
                          onPressed: _followMyLocation,
                        ),
                        IconButton(
                          tooltip:
                              _is3D ? 'Vista de cima' : 'Vista 3D',
                          icon: Icon(
                              _is3D
                                  ? Icons.videogame_asset_off
                                  : Icons.threed_rotation,
                              color: Colors.white),
                          onPressed: _toggleView,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        foregroundColor: Colors.white),
                    onPressed: _openGoogleNavigation,
                    icon: const Icon(Icons.navigation),
                    label: const Text('Navegar no Google'),
                  ),
                ),
              ],
            ),
    );
  }
}

class _WebNotSupported extends StatelessWidget {
  const _WebNotSupported({required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: Text(
        status.isEmpty ? 'Google Maps não suporta Web.' : status,
        style: const TextStyle(color: Colors.white70),
        textAlign: TextAlign.center,
      ),
    );
  }
}
*/
