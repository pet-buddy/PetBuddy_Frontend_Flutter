import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:petbuddy_frontend_flutter/data/repository/auth_repository.dart';

mixin class RegisterController {
  late final WidgetRef registerRef;
  late final BuildContext registerContext;

  void fnInitRegisterController(WidgetRef ref, BuildContext context) {
    registerRef = ref;
    registerContext = context;
  }

  void fnInvalidateRegisterState() {
    registerRef.invalidate(registerEmailInputStatusCodeProvider);
    registerRef.invalidate(registerPwdInputStatusCodeProvider);
    registerRef.invalidate(registerPwdConfirmInputStatusCodeProvider);
    registerRef.invalidate(requestEmailRegisterProvider);
    registerRef.invalidate(registerButtonProvider);
  }

  TextEditingController registerEmailInputController = TextEditingController();
  TextEditingController registerPasswordInputController = TextEditingController();
  TextEditingController registerPasswordConfirmInputController = TextEditingController();

  void fnCheckRegisterEmail(String email) {
    if(email.isEmpty) {
      registerRef
        .read(registerEmailInputStatusCodeProvider.notifier)
        .set(ProjectConstant.INPUT_ERR_EMPTY);
      return;
    }
    if(!fnCheckEmailFormat(email)) {
      registerRef
        .read(registerEmailInputStatusCodeProvider.notifier)
        .set(ProjectConstant.INPUT_ERR_FORMAT);
      return;
    }

    registerRef.read(registerEmailInputStatusCodeProvider.notifier)
               .set(ProjectConstant.INPUT_SUCCESS);
  }

  void fnCheckRegisterPassword(String password) {
    if(password.isEmpty) {
      registerRef.read(registerPwdInputStatusCodeProvider.notifier)
                 .set(ProjectConstant.INPUT_ERR_EMPTY);
      return;
    }

    registerRef.read(registerPwdInputStatusCodeProvider.notifier)
               .set(ProjectConstant.INPUT_SUCCESS);
  }

  void fnCheckRegisterPasswordConfirm(String password, String passwordConfirm) {
    if(passwordConfirm.isEmpty) {
      registerRef.read(registerPwdConfirmInputStatusCodeProvider.notifier)
                 .set(ProjectConstant.INPUT_ERR_EMPTY);
      return;
    }
    if(password != passwordConfirm) {
      registerRef.read(registerPwdConfirmInputStatusCodeProvider.notifier)
                 .set(ProjectConstant.INPUT_ERR_NOT_MATCHED);
      return;
    }

    registerRef.read(registerPwdConfirmInputStatusCodeProvider.notifier)
               .set(ProjectConstant.INPUT_SUCCESS);
  }

  Future<void> fnEmailRegisterExec() async {
    String email = registerRef.read(requestEmailRegisterProvider.notifier).getEmail();
    String password = registerRef.read(requestEmailRegisterProvider.notifier).getPwd();
    String passwordConfirm = registerPasswordConfirmInputController.text;

    debugPrint("========== fnEmailRegisterExec ===========");
    debugPrint("email : $email");
    debugPrint("password : $password");
    debugPrint("passwordConfirm : $passwordConfirm");

    if(email.isEmpty) {
      registerRef
        .read(registerEmailInputStatusCodeProvider.notifier)
        .set(ProjectConstant.INPUT_ERR_EMPTY);

      showAlertDialog(
        context: registerContext, 
        middleText: Sentence.EMAIL_ERR_EMPTY,
      );
      return;
    }
    if(!fnCheckEmailFormat(email)) {
      registerRef
        .read(registerEmailInputStatusCodeProvider.notifier)
        .set(ProjectConstant.INPUT_ERR_FORMAT);

      showAlertDialog(
        context: registerContext, 
        middleText: Sentence.EMAIL_ERR_FORMAT,
      );
      return;
    }

    registerRef.read(registerEmailInputStatusCodeProvider.notifier)
               .set(ProjectConstant.INPUT_SUCCESS);

    if(password.isEmpty) {
      registerRef.read(registerPwdInputStatusCodeProvider.notifier)
                 .set(ProjectConstant.INPUT_ERR_EMPTY);

      showAlertDialog(
        context: registerContext, 
        middleText: Sentence.PWD_ERR_EMPTY,
      );
      return;
    }

    registerRef.read(registerPwdInputStatusCodeProvider.notifier)
               .set(ProjectConstant.INPUT_SUCCESS);

    if(passwordConfirm.isEmpty) {
      registerRef.read(registerPwdConfirmInputStatusCodeProvider.notifier)
                 .set(ProjectConstant.INPUT_ERR_EMPTY);

      showAlertDialog(
        context: registerContext, 
        middleText: Sentence.PWD_CONFIRM_ERR_EMPTY,
      );
      return;
    }
    if(password != passwordConfirm) {
      registerRef.read(registerPwdConfirmInputStatusCodeProvider.notifier)
                 .set(ProjectConstant.INPUT_ERR_NOT_MATCHED);

      showAlertDialog(
        context: registerContext, 
        middleText: Sentence.PWD_ERR_NOT_MATCHED,
      );
      return;
    }

    registerRef.read(registerPwdConfirmInputStatusCodeProvider.notifier)
               .set(ProjectConstant.INPUT_SUCCESS);

    // 로딩 시작
    showLoadingDialog(context: registerContext);

    final storage = registerRef.watch(secureStorageProvider);

    try {
      final response = await registerRef.read(authRepositoryProvider).requestEmailRegisterRepository(
          RequestEmailRegisterModel(
            email: email, 
            password: password,
          ),
      );

      debugPrint("========== Email Register Response =========");
      debugPrint(response.toString());

      if(response.response_code == 200) {
        // TODO : 토큰 저장

        if(!registerContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(registerContext);
        // 페이지 이동
        registerContext.goNamed('home_screen');
      } else {
        if(!registerContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(registerContext);
        // 에러 알림창
        showAlertDialog(
          context: registerContext, 
          middleText: Sentence.REGISTER_FAILED,
        );
        return;
      }
    } on DioException catch(e) {
      debugPrint("========== Email Register Dio Exception ==========");
      debugPrint(e.toString());
      int? errorCode = e.response?.statusCode;

      // TODO : storage에 저장된 값 초기화

      // 로딩 끝
      hideLoadingDialog(registerContext);

      // 에러 알림창
      showAlertDialog(
        context: registerContext, 
        middleText: Sentence.SERVER_ERR,
      );
    }
  }
}
