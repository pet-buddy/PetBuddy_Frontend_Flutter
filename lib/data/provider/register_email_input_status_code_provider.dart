import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';

class RegisterEmailInputStatusCodeState extends StateNotifier<String> {
  RegisterEmailInputStatusCodeState() : super(ProjectConstant.INPUT_INIT);

  void set(String code) {
    state = code;
  }

  String get() {
    return state;
  }
}

final registerEmailInputStatusCodeProvider = 
    StateNotifierProvider<RegisterEmailInputStatusCodeState, String>((ref) => RegisterEmailInputStatusCodeState());