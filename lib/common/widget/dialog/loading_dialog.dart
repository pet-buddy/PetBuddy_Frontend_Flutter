
import 'package:petbuddy_frontend_flutter/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

showLoadingDialog({
  required BuildContext context,
}) {
  showDialog(
    // useRootNavigator: false,
    context: context, 
    barrierDismissible: false,
    barrierColor: CustomColor.gray06.withValues(alpha: 0.0),
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(
          color: CustomColor.blue03,
        ),
      );
  });
}

void hideLoadingDialog(BuildContext context) {
  context.pop();
}