import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';

class EmailLoginPwdInputStatusCodeState extends StateNotifier<String> {
  EmailLoginPwdInputStatusCodeState() : super(ProjectConstant.INPUT_INIT);

  void set(String code) {
    state = code;
  }

  String get() {
    return state;
  }
}

final emailLoginPwdInputStatusCodeProvider = 
    StateNotifierProvider<EmailLoginPwdInputStatusCodeState, String>((ref) => EmailLoginPwdInputStatusCodeState());