import '/auth/firebase_auth/auth_util.dart';
import '/components/navbar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calendar_model.dart';
export 'calendar_model.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  static String routeName = 'Calendar';
  static String routePath = '/calendar';

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late CalendarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).accent2,
        body: AuthUserStreamWidget(
          builder: (context) => Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  valueOrDefault<Color>(
                    () {
                      if ((currentUserDocument?.plaform.toList() ?? [])
                          .contains('Ride Taxi')) {
                        return FlutterFlowTheme.of(context).accent2;
                      } else if ((currentUserDocument?.plaform.toList() ?? [])
                          .contains('Ride Driver')) {
                        return FlutterFlowTheme.of(context).alternate;
                      } else {
                        return FlutterFlowTheme.of(context).accent2;
                      }
                    }(),
                    FlutterFlowTheme.of(context).accent2,
                  ),
                  valueOrDefault<Color>(
                    () {
                      if ((currentUserDocument?.plaform.toList() ?? [])
                          .contains('Ride Taxi')) {
                        return FlutterFlowTheme.of(context).accent3;
                      } else if ((currentUserDocument?.plaform.toList() ?? [])
                          .contains('Ride Driver')) {
                        return FlutterFlowTheme.of(context).alternate;
                      } else {
                        return FlutterFlowTheme.of(context).accent3;
                      }
                    }(),
                    FlutterFlowTheme.of(context).accent3,
                  )
                ],
                stops: [0.0, 1.0],
                begin: AlignmentDirectional(0.0, -1.0),
                end: AlignmentDirectional(0, 1.0),
              ),
            ),
            child: Container(
              height: double.infinity,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 65.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                6.0, 40.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      ' Calendar',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 6.0)),
                                ),
                                Container(
                                  width: 100.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    ' My schedule',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.poppins(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 350.0,
                            height: 300.0,
                            child: custom_widgets.Calendar(
                              width: 350.0,
                              height: 300.0,
                            ),
                          ),
                          Container(
                            height: 420.0,
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 16.0, 16.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 378.0,
                                    decoration: BoxDecoration(
                                      color: valueOrDefault<Color>(
                                        () {
                                          if ((currentUserDocument?.plaform
                                                      .toList() ??
                                                  [])
                                              .contains('Ride Taxi')) {
                                            return FlutterFlowTheme.of(context)
                                                .alternate;
                                          } else if ((currentUserDocument
                                                      ?.plaform
                                                      .toList() ??
                                                  [])
                                              .contains('Ride Driver')) {
                                            return FlutterFlowTheme.of(context)
                                                .primary;
                                          } else {
                                            return FlutterFlowTheme.of(context)
                                                .alternate;
                                          }
                                        }(),
                                        FlutterFlowTheme.of(context).alternate,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          14.0, 14.0, 14.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 4.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      ' Friday, Aug 22',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  () {
                                                                    if ((currentUserDocument?.plaform.toList() ??
                                                                            [])
                                                                        .contains(
                                                                            'Ride Taxi')) {
                                                                      return FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary;
                                                                    } else if ((currentUserDocument?.plaform.toList() ??
                                                                            [])
                                                                        .contains(
                                                                            'Ride Driver')) {
                                                                      return FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate;
                                                                    } else {
                                                                      return FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary;
                                                                    }
                                                                  }(),
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                                fontSize: 18.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 8.0),
                                            child: Container(
                                              width: 350.0,
                                              height: 70.0,
                                              decoration: BoxDecoration(
                                                color: valueOrDefault<Color>(
                                                  () {
                                                    if ((currentUserDocument
                                                                ?.plaform
                                                                .toList() ??
                                                            [])
                                                        .contains(
                                                            'Ride Taxi')) {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .primary;
                                                    } else if ((currentUserDocument
                                                                ?.plaform
                                                                .toList() ??
                                                            [])
                                                        .contains(
                                                            'Ride Driver')) {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .alternate;
                                                    } else {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .primary;
                                                    }
                                                  }(),
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  14.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                'Tourist • Metered • pax 4',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .poppins(
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: valueOrDefault<
                                                                          Color>(
                                                                        () {
                                                                          if ((currentUserDocument?.plaform.toList() ?? []).contains(
                                                                              'Ride Taxi')) {
                                                                            return FlutterFlowTheme.of(context).secondaryText;
                                                                          } else if ((currentUserDocument?.plaform.toList() ?? [])
                                                                              .contains('Ride Driver')) {
                                                                            return FlutterFlowTheme.of(context).primary;
                                                                          } else {
                                                                            return FlutterFlowTheme.of(context).secondaryText;
                                                                          }
                                                                        }(),
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 4.0)),
                                                          ),
                                                          Text(
                                                            '2:30 PM • Atlantis → LPIA',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    () {
                                                                      if ((currentUserDocument?.plaform.toList() ??
                                                                              [])
                                                                          .contains(
                                                                              'Ride Taxi')) {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .alternate;
                                                                      } else if ((currentUserDocument?.plaform.toList() ??
                                                                              [])
                                                                          .contains(
                                                                              'Ride Driver')) {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .primary;
                                                                      } else {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .alternate;
                                                                      }
                                                                    }(),
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 6.0)),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          ' \$32 est.',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .poppins(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  () {
                                                                    if ((currentUserDocument?.plaform.toList() ??
                                                                            [])
                                                                        .contains(
                                                                            'Ride Taxi')) {
                                                                      return FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText;
                                                                    } else if ((currentUserDocument?.plaform.toList() ??
                                                                            [])
                                                                        .contains(
                                                                            'Ride Driver')) {
                                                                      return FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary;
                                                                    } else {
                                                                      return FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText;
                                                                    }
                                                                  }(),
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        Container(
                                                          width: 80.0,
                                                          height: 26.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                valueOrDefault<
                                                                    Color>(
                                                              () {
                                                                if ((currentUserDocument
                                                                            ?.plaform
                                                                            .toList() ??
                                                                        [])
                                                                    .contains(
                                                                        'Ride Taxi')) {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate;
                                                                } else if ((currentUserDocument
                                                                            ?.plaform
                                                                            .toList() ??
                                                                        [])
                                                                    .contains(
                                                                        'Ride Driver')) {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary;
                                                                } else {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate;
                                                                }
                                                              }(),
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .alternate,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Text(
                                                            'Accept',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 4.0)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 8.0),
                                            child: Container(
                                              width: 350.0,
                                              height: 70.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 8.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  14.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                'Local • App Fare • pax 4',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .poppins(
                                                                        fontWeight:
                                                                            FontWeight.w300,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: valueOrDefault<
                                                                          Color>(
                                                                        () {
                                                                          if ((currentUserDocument?.plaform.toList() ?? []).contains(
                                                                              'Ride Taxi')) {
                                                                            return FlutterFlowTheme.of(context).secondaryText;
                                                                          } else if ((currentUserDocument?.plaform.toList() ?? [])
                                                                              .contains('Ride Driver')) {
                                                                            return FlutterFlowTheme.of(context).primary;
                                                                          } else {
                                                                            return FlutterFlowTheme.of(context).secondaryText;
                                                                          }
                                                                        }(),
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 4.0)),
                                                          ),
                                                          Text(
                                                            ' 4:30 PM • Bay St → Paradise',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    () {
                                                                      if ((currentUserDocument?.plaform.toList() ??
                                                                              [])
                                                                          .contains(
                                                                              'Ride Taxi')) {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .alternate;
                                                                      } else if ((currentUserDocument?.plaform.toList() ??
                                                                              [])
                                                                          .contains(
                                                                              'Ride Driver')) {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .primary;
                                                                      } else {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .alternate;
                                                                      }
                                                                    }(),
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 6.0)),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '\$18 • 7 min',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .poppins(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  () {
                                                                    if ((currentUserDocument?.plaform.toList() ??
                                                                            [])
                                                                        .contains(
                                                                            'Ride Taxi')) {
                                                                      return FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText;
                                                                    } else if ((currentUserDocument?.plaform.toList() ??
                                                                            [])
                                                                        .contains(
                                                                            'Ride Driver')) {
                                                                      return FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary;
                                                                    } else {
                                                                      return FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText;
                                                                    }
                                                                  }(),
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                        Container(
                                                          width: 80.0,
                                                          height: 26.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                valueOrDefault<
                                                                    Color>(
                                                              () {
                                                                if ((currentUserDocument
                                                                            ?.plaform
                                                                            .toList() ??
                                                                        [])
                                                                    .contains(
                                                                        'Ride Taxi')) {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate;
                                                                } else if ((currentUserDocument
                                                                            ?.plaform
                                                                            .toList() ??
                                                                        [])
                                                                    .contains(
                                                                        'Ride Driver')) {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary;
                                                                } else {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate;
                                                                }
                                                              }(),
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .alternate,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Text(
                                                            'View',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 4.0)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                ' Friday, Aug 22',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 18.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 8.0),
                                            child: Container(
                                              width: 350.0,
                                              height: 81.2,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
                                                    FlutterFlowTheme.of(context)
                                                        .success
                                                  ],
                                                  stops: [0.0, 1.0],
                                                  begin: AlignmentDirectional(
                                                      -0.34, 1.0),
                                                  end: AlignmentDirectional(
                                                      0.34, -1.0),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 10.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  14.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                'Tourist • Metered • pax 4',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .poppins(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: valueOrDefault<
                                                                          Color>(
                                                                        () {
                                                                          if ((currentUserDocument?.plaform.toList() ?? []).contains(
                                                                              'Ride Taxi')) {
                                                                            return FlutterFlowTheme.of(context).secondaryText;
                                                                          } else if ((currentUserDocument?.plaform.toList() ?? [])
                                                                              .contains('Ride Driver')) {
                                                                            return FlutterFlowTheme.of(context).primary;
                                                                          } else {
                                                                            return FlutterFlowTheme.of(context).secondaryText;
                                                                          }
                                                                        }(),
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 4.0)),
                                                          ),
                                                          Text(
                                                            '2:30 PM • Bahamar→ LPIA',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    () {
                                                                      if ((currentUserDocument?.plaform.toList() ??
                                                                              [])
                                                                          .contains(
                                                                              'Ride Taxi')) {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .alternate;
                                                                      } else if ((currentUserDocument?.plaform.toList() ??
                                                                              [])
                                                                          .contains(
                                                                              'Ride Driver')) {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .primary;
                                                                      } else {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .alternate;
                                                                      }
                                                                    }(),
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                  ),
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 6.0)),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  8.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        20.0),
                                                            child: Text(
                                                              ' \$32 est.',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .poppins(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: valueOrDefault<
                                                                        Color>(
                                                                      () {
                                                                        if ((currentUserDocument?.plaform.toList() ??
                                                                                [])
                                                                            .contains(
                                                                                'Ride Taxi')) {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .alternate;
                                                                        } else if ((currentUserDocument?.plaform.toList() ??
                                                                                [])
                                                                            .contains('Ride Driver')) {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .primary;
                                                                        } else {
                                                                          return FlutterFlowTheme.of(context)
                                                                              .alternate;
                                                                        }
                                                                      }(),
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width: 50.0,
                                                                height: 18.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24.0),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  'Cancel',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .poppins(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 60.0,
                                                                height: 18.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    () {
                                                                      if ((currentUserDocument?.plaform.toList() ??
                                                                              [])
                                                                          .contains(
                                                                              'Ride Taxi')) {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .alternate;
                                                                      } else if ((currentUserDocument?.plaform.toList() ??
                                                                              [])
                                                                          .contains(
                                                                              'Ride Driver')) {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .primary;
                                                                      } else {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .alternate;
                                                                      }
                                                                    }(),
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              24.0),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Text(
                                                                  'Confirmed',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .poppins(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          () {
                                                                            if ((currentUserDocument?.plaform.toList() ?? []).contains('Ride Taxi')) {
                                                                              return FlutterFlowTheme.of(context).primaryText;
                                                                            } else if ((currentUserDocument?.plaform.toList() ?? []).contains('Ride Driver')) {
                                                                              return FlutterFlowTheme.of(context).alternate;
                                                                            } else {
                                                                              return FlutterFlowTheme.of(context).primaryText;
                                                                            }
                                                                          }(),
                                                                          FlutterFlowTheme.of(context)
                                                                              .primaryText,
                                                                        ),
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 5.0)),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 4.0)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                                AddAvailabilityWidget
                                                    .routeName);
                                          },
                                          child: Container(
                                            width: 170.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              color: valueOrDefault<Color>(
                                                () {
                                                  if ((currentUserDocument
                                                              ?.plaform
                                                              .toList() ??
                                                          [])
                                                      .contains('Ride Taxi')) {
                                                    return FlutterFlowTheme.of(
                                                            context)
                                                        .primary;
                                                  } else if ((currentUserDocument
                                                              ?.plaform
                                                              .toList() ??
                                                          [])
                                                      .contains(
                                                          'Ride Driver')) {
                                                    return FlutterFlowTheme.of(
                                                            context)
                                                        .secondary;
                                                  } else {
                                                    return FlutterFlowTheme.of(
                                                            context)
                                                        .primary;
                                                  }
                                                }(),
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              ' Add Availability',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color:
                                                        valueOrDefault<Color>(
                                                      () {
                                                        if ((currentUserDocument
                                                                    ?.plaform
                                                                    .toList() ??
                                                                [])
                                                            .contains(
                                                                'Ride Taxi')) {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate;
                                                        } else if ((currentUserDocument
                                                                    ?.plaform
                                                                    .toList() ??
                                                                [])
                                                            .contains(
                                                                'Ride Driver')) {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .primary;
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate;
                                                        }
                                                      }(),
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                    ),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                                ScheduleRideWidget.routeName);
                                          },
                                          child: Container(
                                            width: 170.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              color: valueOrDefault<Color>(
                                                () {
                                                  if ((currentUserDocument
                                                              ?.plaform
                                                              .toList() ??
                                                          [])
                                                      .contains('Ride Taxi')) {
                                                    return FlutterFlowTheme.of(
                                                            context)
                                                        .primary;
                                                  } else if ((currentUserDocument
                                                              ?.plaform
                                                              .toList() ??
                                                          [])
                                                      .contains(
                                                          'Ride Driver')) {
                                                    return FlutterFlowTheme.of(
                                                            context)
                                                        .secondary;
                                                  } else {
                                                    return FlutterFlowTheme.of(
                                                            context)
                                                        .primary;
                                                  }
                                                }(),
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'Schedule Ride',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color:
                                                        valueOrDefault<Color>(
                                                      () {
                                                        if ((currentUserDocument
                                                                    ?.plaform
                                                                    .toList() ??
                                                                [])
                                                            .contains(
                                                                'Ride Taxi')) {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate;
                                                        } else if ((currentUserDocument
                                                                    ?.plaform
                                                                    .toList() ??
                                                                [])
                                                            .contains(
                                                                'Ride Driver')) {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .primary;
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate;
                                                        }
                                                      }(),
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                    ),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: double.infinity,
                      height: 65.0,
                      child: Stack(
                        children: [
                          wrapWithModel(
                            model: _model.navbarModel,
                            updateCallback: () => safeSetState(() {}),
                            child: NavbarWidget(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
