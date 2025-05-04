import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:petbuddy_frontend_flutter/data/repository/repository.dart';

mixin class LoginController {
  late final WidgetRef loginRef;
  late final BuildContext loginContext;

  void fnInitLoginController(WidgetRef ref, BuildContext context) {
    loginRef = ref;
    loginContext = context;
  }

  void fnInitEmailLoginState() {
    loginRef.invalidate(emailLoginEmailInputStatusCodeProvider);
    loginRef.invalidate(emailLoginPwdInputStatusCodeProvider);
    loginRef.invalidate(emailLoginButtonProvider);
  }

  // 이메일 로그인에서 사용할 입력 컨트롤러
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  void fnCheckEmail(String email) {
    if(email.isEmpty) {
      loginRef
        .read(emailLoginEmailInputStatusCodeProvider.notifier)
        .set(ProjectConstant.INPUT_ERR_EMPTY);
      return;
    }
    if(!fnCheckEmailFormat(email)) {
      loginRef
        .read(emailLoginEmailInputStatusCodeProvider.notifier)
        .set(ProjectConstant.INPUT_ERR_FORMAT);
      return;
    }

    loginRef.read(emailLoginEmailInputStatusCodeProvider.notifier)
            .set(ProjectConstant.INPUT_SUCCESS);
  }

  void fnCheckPassword(String password) {
    if(password.isEmpty) {
      loginRef.read(emailLoginPwdInputStatusCodeProvider.notifier)
              .set(ProjectConstant.INPUT_ERR_EMPTY);
      return;
    }

    loginRef.read(emailLoginPwdInputStatusCodeProvider.notifier)
            .set(ProjectConstant.INPUT_SUCCESS);
  }

  Future<void> fnEmailLoginExec() async {
    String email = loginRef.read(requestEmailLoginProvider.notifier).getEmail();
    String password = loginRef.read(requestEmailLoginProvider.notifier).getPwd();

    if(email.isEmpty) {
      loginRef
        .read(emailLoginEmailInputStatusCodeProvider.notifier)
        .set(ProjectConstant.INPUT_ERR_EMPTY);

      showAlertDialog(
        context: loginContext, 
        middleText: Sentence.EMAIL_ERR_EMPTY,
      );
      return;
    }
    if(!fnCheckEmailFormat(email)) {
      loginRef
        .read(emailLoginEmailInputStatusCodeProvider.notifier)
        .set(ProjectConstant.INPUT_ERR_FORMAT);

      showAlertDialog(
        context: loginContext, 
        middleText: Sentence.EMAIL_ERR_FORMAT,
      );
      return;
    }

    loginRef.read(emailLoginEmailInputStatusCodeProvider.notifier)
            .set(ProjectConstant.INPUT_SUCCESS);

    if(password.isEmpty) {
      loginRef.read(emailLoginPwdInputStatusCodeProvider.notifier)
              .set(ProjectConstant.INPUT_ERR_EMPTY);

      showAlertDialog(
        context: loginContext, 
        middleText: Sentence.PWD_ERR_EMPTY,
      );
      return;
    }

    loginRef.read(emailLoginPwdInputStatusCodeProvider.notifier)
            .set(ProjectConstant.INPUT_SUCCESS);

    // 로딩 시작
    showLoadingDialog(context: loginContext);

    final storage = loginRef.watch(secureStorageProvider);

    try {
      final response = await loginRef.read(userRepositoryProvider).requestEmailLoginRepository(
          RequestEmailLoginModel(
            email: email, 
            password: password
          ),
      );

      debugPrint("========== Email Login Response =========");
      debugPrint(response.toString());

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
      print(e);
      int? errorCode = e.response?.statusCode;

      // TODO : storage에 저장된 값 초기화

      // 로딩 끝
      hideLoadingDialog(loginContext);

      // 임시 - 페이지 이동
      // loginContext.goNamed('home_screen');

      // 에러 알림창
      showAlertDialog(
        context: loginContext, 
        middleText: Sentence.SERVER_ERR,
      );
    }
  }
}
