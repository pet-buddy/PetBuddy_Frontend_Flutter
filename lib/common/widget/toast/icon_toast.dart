import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';

void iconToast(context, message, imgWidget, {double bottom = 50}) {
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = SizedBox(
    width: fnGetDeviceWidth(context),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 45,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: CustomColor.black.withValues(alpha: 0.8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imgWidget,
            ),
            const SizedBox(width: 12.0,),
            Flexible(
              child: Text(
                '$message',
                style: CustomText.caption2.copyWith(
                  color: CustomColor.white,
                )
              ),
            ),
            const SizedBox(
              width: 12.0,
            ),
          ],
        ),
      ),
    ),
  );

  FToast().showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM ,
    toastDuration: const Duration(seconds: 2),
    positionedToastBuilder: (context, child, gravity) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: bottom, 
            child: child,
          ),
        ], 
      );
    },
  );
}