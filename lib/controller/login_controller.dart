import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
import 'package:petbuddy_frontend_flutter/controller/controller_utils.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:petbuddy_frontend_flutter/data/repository/repository.dart';
import 'package:petbuddy_frontend_flutter/route/go_security_provider.dart';

mixin class LoginController {
  late final WidgetRef loginRef;
  late final BuildContext loginContext;

  void fnInitLoginController(WidgetRef ref, BuildContext context) {
    loginRef = ref;
    loginContext = context;
  }

  void fnInvalidateEmailLoginState() {
    loginRef.invalidate(emailLoginEmailInputStatusCodeProvider);
    loginRef.invalidate(emailLoginPwdInputStatusCodeProvider);
    loginRef.invalidate(emailLoginButtonProvider);
  }

  void fnInitEmailLoginState() {
    loginRef.read(emailLoginEmailInputStatusCodeProvider.notifier).set(ProjectConstant.INPUT_INIT);
    loginRef.read(emailLoginPwdInputStatusCodeProvider.notifier).set(ProjectConstant.INPUT_INIT);
    loginRef.read(emailLoginButtonProvider.notifier).set(false);
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

      // debugPrint("========== Email Login Response =========");
      // debugPrint(response.toString());

      if(response.response_code == 200) {
        ResponseEmailLoginModel responseEmailLoginModel = ResponseEmailLoginModel.fromJson(response.data!);
        // 토큰 저장
        await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: responseEmailLoginModel.accessToken);
        await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: responseEmailLoginModel.refreshToken);
        // 사용자 정보 조회
        if(!loginContext.mounted) return;
        await ControllerUtils.fnGetUserMypageExec(loginRef, loginContext);
        // 반려동물 정보 조회
        if(!loginContext.mounted) return;
        await ControllerUtils.fnGetDogsExec(loginRef, loginContext);

        // 활성화된 반려동물 인덱스 불러오기
        final petActivatedIndex = await storage.read(key: ProjectConstant.PET_ACTIVATED_INDEX);
        if (petActivatedIndex != null) {
          loginRef.read(homeActivatedPetNavProvider.notifier).set(
            int.parse(petActivatedIndex)
          );
        }

        // 라우터 처리를 위한 상태 갱신
        loginRef.read(goSecurityProvider.notifier).set(true); 

        if(!loginContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(loginContext);
        // Provider 해제(무효화)
        fnInvalidateEmailLoginState();
        // 페이지 이동
        loginContext.goNamed('home_screen');
      } else {
        if(!loginContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(loginContext);
        // 에러 알림창
        showAlertDialog(
          context: loginContext, 
          middleText: "이메일 또는 비밀번호를 확인해주세요.\n${response.response_message}"
        );
        return;
      }
    } on DioException catch(e) {
      // debugPrint("========== Email Login Dio Exception ==========");
      // debugPrint(e.toString());
      
      // int? errorCode = e.response?.statusCode;
      // debugPrint(errorCode.toString());

      // storage에 저장된 값 초기화
      await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: null);
      await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: null);

      // 로딩 끝
      if(!loginContext.mounted) return;
      hideLoadingDialog(loginContext);

      // 에러 알림창
      showAlertDialog(
        context: loginContext, 
        middleText: Sentence.SERVER_ERR,
      );
    }
  }
}
