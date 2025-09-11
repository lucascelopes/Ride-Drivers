import '/flutter_flow/flutter_flow_util.dart';
import 'bottom_shett_mensagem_widget.dart' show BottomShettMensagemWidget;
import 'package:flutter/material.dart';

class BottomShettMensagemModel
    extends FlutterFlowModel<BottomShettMensagemWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
