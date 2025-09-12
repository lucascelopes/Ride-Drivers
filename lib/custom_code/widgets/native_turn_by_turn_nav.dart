import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import 'driver_on_ride_model.dart';
export 'driver_on_ride_model.dart';

class DriverOnRideWidget extends StatefulWidget {
  const DriverOnRideWidget({
    super.key,
    required this.apiKey,
    required this.userLatLng,
    required this.placeLatLng,
    required this.width,
    required this.height,
  });

  final String apiKey;
  final ff.LatLng userLatLng;
  final ff.LatLng placeLatLng;
  final double width;
  final double height;
    required this.driverOrder,
  });

  final DocumentReference? driverOrder;

  static String routeName = 'DriverOnRide';
  static String routePath = '/driverOnRide';

  @override
  State<DriverOnRideWidget> createState() => _DriverOnRideWidgetState();
}

    final params = <String, dynamic>{
      'userLat': userLatLng.latitude,
      'userLng': userLatLng.longitude,
      'destLat': placeLatLng.latitude,
      'destLng': placeLatLng.longitude,
      'apiKey': apiKey,
    };
class _DriverOnRideWidgetState extends State<DriverOnRideWidget> {
  late DriverOnRideModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DriverOnRideModel());

    getCurrentUserLocation(
      defaultLocation: const LatLng(0.0, 0.0),
      cached: true,
    ).then((loc) => safeSetState(() => currentUserLocationValue = loc));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        ),
      );
    }

    return StreamBuilder<RideOrdersRecord>(
      stream: RideOrdersRecord.getDocument(widget.driverOrder!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final driverOnRideRideOrdersRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: Stack(
              children: [
                // Apenas o nativo em cima, via PlatformView:
                PointerInterceptor(
                  intercepting: isWeb,
                  child: AuthUserStreamWidget(
                    builder: (context) => SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: custom_widgets.NativeTurnByTurnNav(
                        width: double.infinity,
                        height: double.infinity,
                        // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                        apiKey: 'AIzaSyCFBfcNHFg97sM7EhKnAP4OHIoY3Q8Y_xQ',
                        // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                        arrivalRadiusMeters: 30.0,
                        useDeviceCompass: true,
                        userLatLng: driverOnRideRideOrdersRecord.latlngAtual!,
                        initialDriverLatLng: currentUserDocument?.location,
                        placeLatLng: driverOnRideRideOrdersRecord.latlng!,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
