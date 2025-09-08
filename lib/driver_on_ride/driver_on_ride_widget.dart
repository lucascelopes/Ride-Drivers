import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'driver_on_ride_model.dart';
export 'driver_on_ride_model.dart';

class DriverOnRideWidget extends StatefulWidget {
  const DriverOnRideWidget({
    super.key,
    required this.driverOrder,
  });

  final DocumentReference? driverOrder;

  static String routeName = 'DriverOnRide';
  static String routePath = '/driverOnRide';

  @override
  State<DriverOnRideWidget> createState() => _DriverOnRideWidgetState();
}

class _DriverOnRideWidgetState extends State<DriverOnRideWidget> {
  late DriverOnRideModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DriverOnRideModel());

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
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
            width: 50,
            height: 50,
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
      stream: RideOrdersRecord.getDocument(widget!.driverOrder!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
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
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: Stack(
              children: [
                AuthUserStreamWidget(
                  builder: (context) => Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: custom_widgets.TurnByTurnNav(
                      width: double.infinity,
                      height: double.infinity,
                      apiKey: 'AIzaSyCFBfcNHFg97sM7EhKnAP4OHIoY3Q8Y_xQ',
                      arrivalRadiusMeters: 30.0,
                      simulateIfNoGPS: false,
                      useDeviceCompass: false,
                      userLatLng: driverOnRideRideOrdersRecord.latlngAtual!,
                      initialDriverLatLng: currentUserDocument?.location,
                      placeLatLng: driverOnRideRideOrdersRecord.latlng!,
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
