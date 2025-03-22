
import 'package:petbuddy_frontend_flutter/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

showOverlayLoadingDialog({
  required BuildContext context,
}) {
  showDialog(
    // useRootNavigator: false,
    context: context, 
    barrierDismissible: false,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(
          color: CustomColor.blue03,
        ),
      );
  });
}

void hideOverlayLoadingDialog(BuildContext context) {
  context.pop();
}