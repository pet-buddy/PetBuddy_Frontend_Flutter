
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/widget/toast/icon_toast.dart';

DateTime? backButtonPressedTime;

Future<bool> fnClose(BuildContext context){

  DateTime now = DateTime.now();

  if(backButtonPressedTime == null || now.difference(backButtonPressedTime!)
      > const Duration(seconds: 2))
  {

    backButtonPressedTime = now;
    const message = "한 번 더 누르시면 종료됩니다.";

    final router = GoRouter.of(context);
    String pathName = router.routerDelegate.currentConfiguration.matches.last.matchedLocation;
    
    iconToast(
      context, 
      message, 
      Image.asset(
        'assets/icons/logo/app_logo.png',
        width: 24,
        height: 24,
      ),
      bottom: pathName == '/login_screen' ? 
        MediaQuery.of(context).viewPadding.bottom + 50 : 
        0,
    );
    return Future.value(false);
  }
  SystemNavigator.pop();
  return Future.value(true);
}