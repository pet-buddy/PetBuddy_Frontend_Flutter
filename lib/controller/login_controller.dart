import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
import 'package:petbuddy_frontend_flutter/common/widget/widget.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
import 'package:petbuddy_frontend_flutter/data/repository/auth_repository.dart';

mixin class LoginController {
  late final WidgetRef loginRef;
  late final BuildContext loginContext;

  void fnInitLoginController(WidgetRef ref, BuildContext context) {
    loginRef = ref;
    loginContext = context;
  }

  // 이메일 로그인에서 사용할 입력 컨트롤러
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  Future<void> fnEmailLoginExec() async {
    String email = loginRef.read(emailLoginInputProvider.notifier).getEmail();
    String password = loginRef.read(emailLoginInputProvider.notifier).getPwd();

    if(email.isEmpty) {
      showAlertDialog(
        context: loginContext, 
        middleText: "이메일을 입력해주세요."
      );
      return;
    }
    if(password.isEmpty) {
      showAlertDialog(
        context: loginContext, 
        middleText: "비밀번호를 입력해주세요."
      );
      return;
    }

    // 로딩 시작
    showLoadingDialog(context: loginContext);

    final storage = loginRef.watch(secureStorageProvider);

    try {
      final response = await loginRef.read(authRepositoryProvider).requestEmailLoginRepository(
          RequestEmailLoginModel(
            email: email, 
            password: password
          ),
      );

      if(response.response_code == 200) {
        // TODO : 토큰 저장

        if(!loginContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(loginContext);
        // 페이지 이동
        loginContext.goNamed('home_screen');
      } else {
        if(!loginContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(loginContext);
        // 에러 알림창
        showAlertDialog(
          context: loginContext, 
          middleText: "이메일 또는 비밀번호를 확인해주세요."
        );
        return;
      }
    } on DioException catch(e) {
      debugPrint("========== Email Login Dio Exception ==========");
      
      int? errorCode = e.response?.statusCode;

      // TODO : storage에 저장된 값 초기화

      // 로딩 끝
      hideLoadingDialog(loginContext);

      // 임시 - 페이지 이동
      loginContext.goNamed('home_screen');

      // 에러 알림창
      showAlertDialog(
        context: loginContext, 
        middleText: "서버와 통신 중 오류가 발생했습니다."
      );
    }
  }
}
