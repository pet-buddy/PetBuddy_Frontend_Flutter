import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';

class MyProfilePhoneNumberInputStatusCodeState extends StateNotifier<String> {
  MyProfilePhoneNumberInputStatusCodeState() : super(ProjectConstant.INPUT_INIT);

  void set(String code) {
    state = code;
  }

  String get() {
    return state;
  }
}

final myProfilePhoneNumberInputStatusCodeProvider = 
    StateNotifierProvider<MyProfilePhoneNumberInputStatusCodeState, String>((ref) => MyProfilePhoneNumberInputStatusCodeState());