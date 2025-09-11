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

// Native Turn-by-turn navigation using platform views (Android).
// Não usa google_maps_flutter. O mapa é nativo via PlatformView.

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '/flutter_flow/lat_lng.dart' as ff;

class NativeTurnByTurnNav extends StatelessWidget {
  const NativeTurnByTurnNav({
    super.key,
    required this.apiKey,
    required this.userLatLng,       // pickup
    required this.placeLatLng,      // destino
    this.initialDriverLatLng,       // origem opcional (driver)
    this.arrivalRadiusMeters = 25.0,
    this.useDeviceCompass = true,
    required this.width,
    required this.height,
  });

  final String apiKey;
  final ff.LatLng userLatLng;
  final ff.LatLng placeLatLng;
  final ff.LatLng? initialDriverLatLng;
  final double arrivalRadiusMeters;
  final bool useDeviceCompass;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Center(child: Text('Native navigation não suportado no Web.'));
    }

    final params = <String, dynamic>{
      'apiKey': apiKey,
      'userLat': userLatLng.latitude,
      'userLng': userLatLng.longitude,
      'destLat': placeLatLng.latitude,
      'destLng': placeLatLng.longitude,
      'hasOrigin': initialDriverLatLng != null,
      'originLat': initialDriverLatLng?.latitude ?? 0.0,
      'originLng': initialDriverLatLng?.longitude ?? 0.0,
      'arrivalRadius': arrivalRadiusMeters,
      'useCompass': useDeviceCompass,
    };

    if (defaultTargetPlatform == TargetPlatform.android) {
      return SizedBox(
        width: width,
        height: height,
        child: AndroidView(
          viewType: 'NativeTurnByTurnNav',
          // layoutDirection REMOVIDO para evitar incompatibilidade de versão
          creationParams: params,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // Placeholder por enquanto
      return const Center(child: Text('iOS pendente (MapKit).'));
    }

    return const Center(child: Text('Plataforma não suportada.'));
  }
}
