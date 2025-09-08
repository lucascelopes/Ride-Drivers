// Automatic FlutterFlow imports
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

// In-app turn-by-turn com Google Navigation SDK (Android/iOS; Web não suportado)
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_navigation_flutter/google_navigation_flutter.dart'
    as gnav;
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

class _TurnByTurnNavState extends State<TurnByTurnNav> {
  gnav.GoogleNavigationViewController? _view;
  StreamSubscription? _timeDistSub;
  StreamSubscription? _arriveSub;
  StreamSubscription? _snapSub;

  String _status = 'Inicializando...';
  String _etaText = '';
  double _remainingMeters = 0;

  bool _sessionReady = false;
  bool _guidanceRunning = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _status = 'Google Navigation não suporta Web.';
    }
  }

  @override
  void dispose() {
    _timeDistSub?.cancel();
    _arriveSub?.cancel();
    _snapSub?.cancel();
    gnav.GoogleMapsNavigator.stopGuidance();
    super.dispose();
  }

  gnav.LatLng _toG(ff.LatLng v) =>
      gnav.LatLng(latitude: v.latitude, longitude: v.longitude);

  Future<void> _ensureSession() async {
    if (_sessionReady) return;

    // Termos de uso
    final accepted = await gnav.GoogleMapsNavigator.areTermsAccepted();
    if (!accepted) {
      await gnav.GoogleMapsNavigator.showTermsAndConditionsDialog(
        'Terms of Service',
        'Your Company',
      );
    }

    await gnav.GoogleMapsNavigator.initializeNavigationSession();
    // iOS: permissão para updates em background (voz/rota)
    await gnav.GoogleMapsNavigator.allowBackgroundLocationUpdates(true);

    _sessionReady = true;
  }

  Future<void> _listenEvents() async {
    // Atualiza ETA e distância restante (usando o evento + leitura oficial do SDK)
    _timeDistSub?.cancel();
    _timeDistSub = (await gnav.GoogleMapsNavigator
        .setOnRemainingTimeOrDistanceChangedListener((evt) async {
      final tnd = await gnav.GoogleMapsNavigator.getCurrentTimeAndDistance();
      setState(() {
        _etaText = _fmtEta(tnd.time.round());
        _remainingMeters = tnd.distance;
      });
    }));

    // Chegada em waypoint/destino
    _arriveSub?.cancel();
    _arriveSub =
        (await gnav.GoogleMapsNavigator.setOnArrivalListener((onArrive) async {
      final next = await gnav.GoogleMapsNavigator.continueToNextDestination();
      if (next == null) {
        setState(() {
          _status = 'Chegou ao destino. Corrida concluída.';
          _guidanceRunning = false;
        });
      }
    }));

    // Localização "road-snapped"
    _snapSub?.cancel();
    _snapSub =
        (await gnav.GoogleMapsNavigator.setRoadSnappedLocationUpdatedListener(
            (evt) {
      if (!_guidanceRunning) return;
      setState(() => _status = 'Navegando...');
    }));
  }

  Future<void> _startNav() async {
    if (kIsWeb) return;

    setState(() => _status = 'Preparando navegação...');
    await _ensureSession();
    await _listenEvents();

    // Destinos em sequência: pickup -> destination
    final pickup = gnav.NavigationWaypoint.withLatLngTarget(
      title: 'Pickup',
      target: _toG(widget.userLatLng),
    );
    final drop = gnav.NavigationWaypoint.withLatLngTarget(
      title: 'Destination',
      target: _toG(widget.placeLatLng),
    );

    final display = gnav.NavigationDisplayOptions();

    final dests = gnav.Destinations(
      waypoints: [pickup, drop],
      displayOptions: display,
    );

    await gnav.GoogleMapsNavigator.setDestinations(dests);
    await gnav.GoogleMapsNavigator.startGuidance();

    // UI do widget de navegação:
    await _view?.setNavigationUIEnabled(true);

    // Seguir meu local (agora exige CameraPerspective)
    await _view?.followMyLocation(
      gnav.CameraPerspective.tilted,
      // opcional: zoomLevel: 17,
    ); // ← requer parâmetro na 0.6.4

    // Estado inicial de ETA/distância
    final tnd = await gnav.GoogleMapsNavigator.getCurrentTimeAndDistance();
    setState(() {
      _etaText = _fmtEta(tnd.time.round());
      _remainingMeters = tnd.distance;
      _status = 'Navegando...';
      _guidanceRunning = true;
    });
  }

  String _fmtEta(int seconds) {
    if (seconds <= 59) return '1 min';
    final mins = (seconds / 60).ceil();
    return '$mins min';
  }

  String _fmtKm(double meters) {
    if (meters < 1000) return '${meters.round()} m';
    return '${(meters / 1000).toStringAsFixed(1)} km';
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
                gnav.GoogleMapsNavigationView(
                  onViewCreated:
                      (gnav.GoogleNavigationViewController controller) async {
                    _view = controller;
                    await _view?.setNavigationUIEnabled(true);
                    await _startNav();
                  },
                ),
                // Overlay leve de status/ETA
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
                          onPressed: () => _view?.showRouteOverview(),
                        ),
                        IconButton(
                          tooltip: 'Seguir meu local',
                          icon: const Icon(Icons.center_focus_strong,
                              color: Colors.white),
                          onPressed: () => _view?.followMyLocation(
                            gnav.CameraPerspective.tilted,
                            // zoomLevel: 17,
                          ),
                        ),
                      ],
                    ),
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
        status.isEmpty ? 'Google Navigation não suporta Web.' : status,
        style: const TextStyle(color: Colors.white70),
        textAlign: TextAlign.center,
      ),
    );
  }
}
