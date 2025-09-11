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

// Native Turn-by-turn navigation using platform views.
// This widget hosts a native MapView (Google Maps on Android, MapKit on iOS)
// and displays the destination with the device's compass enabled.
// API mirrors TurnByTurnNav but uses fully native map views without
// relying on the google_maps_flutter plugin.

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '/flutter_flow/lat_lng.dart' as ff;

class NativeTurnByTurnNav extends StatelessWidget {
  const NativeTurnByTurnNav({
    super.key,
    required this.userLatLng,
    required this.placeLatLng,
    required this.width,
    required this.height,
  });

  final ff.LatLng userLatLng;
  final ff.LatLng placeLatLng;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Text('Native navigation not supported on web.');
    }

    final params = <String, dynamic>{
      'userLat': userLatLng.latitude,
      'userLng': userLatLng.longitude,
      'destLat': placeLatLng.latitude,
      'destLng': placeLatLng.longitude,
    };

    if (defaultTargetPlatform == TargetPlatform.android) {
      return SizedBox(
        width: width,
        height: height,
          child: AndroidView(
            viewType: 'NativeTurnByTurnNav',
            creationParams: params,
            creationParamsCodec: const StandardMessageCodec(),
          ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return SizedBox(
        width: width,
        height: height,
          child: UiKitView(
            viewType: 'NativeTurnByTurnNav',
            creationParams: params,
            creationParamsCodec: const StandardMessageCodec(),
          ),
      );
    }

    return const Text('Native navigation not implemented for this platform.');
  }
}

