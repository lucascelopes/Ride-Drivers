import '/flutter_flow/lat_lng.dart' as ff;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Displays a native map view for turn-by-turn navigation on Android and iOS.
///
/// This widget wraps a platform-specific implementation exposed via
/// the `NativeTurnByTurnNav` view type. On web and unsupported platforms a
/// simple placeholder is rendered.
class NativeTurnByTurnNav extends StatelessWidget {
  const NativeTurnByTurnNav({
    super.key,
    required this.apiKey,
    required this.userLatLng,
    required this.placeLatLng,
    required this.width,
    required this.height,
    this.arrivalRadiusMeters = 25,
    this.useDeviceCompass = true,
    this.initialDriverLatLng,
  });

  final String apiKey;
  final ff.LatLng userLatLng;
  final ff.LatLng placeLatLng;
  final double width;
  final double height;
  final double arrivalRadiusMeters;
  final bool useDeviceCompass;
  final ff.LatLng? initialDriverLatLng;

  @override
  Widget build(BuildContext context) {
    final params = <String, dynamic>{
      'userLat': userLatLng.latitude,
      'userLng': userLatLng.longitude,
      'destLat': placeLatLng.latitude,
      'destLng': placeLatLng.longitude,
      'apiKey': apiKey,
    };

    if (kIsWeb) {
      return SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: Text('Native navigation is not supported on web.'),
        ),
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return SizedBox(
          width: width,
          height: height,
          child: AndroidView(
            viewType: 'NativeTurnByTurnNav',
            layoutDirection: TextDirection.ltr,
            creationParams: params,
            creationParamsCodec: const StandardMessageCodec(),
          ),
        );
      case TargetPlatform.iOS:
        return SizedBox(
          width: width,
          height: height,
          child: UiKitView(
            viewType: 'NativeTurnByTurnNav',
            layoutDirection: TextDirection.ltr,
            creationParams: params,
            creationParamsCodec: const StandardMessageCodec(),
          ),
        );
      default:
        return SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: Text('Native navigation is not supported on this platform.'),
          ),
        );
    }
  }
}
