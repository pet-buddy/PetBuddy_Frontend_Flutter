import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/utils/fn_check_email_format.dart';

class RegisterButtonState extends StateNotifier<bool> {
  RegisterButtonState() : super(false);

  void activate(String email, String pwd, String pwdConfirm) {
    state = true;

    if(email.isEmpty) {
      state = false;
    } 
    if(!fnCheckEmailFormat(email)) {
      state = false;
    }
    if(pwd.isEmpty) { 
      state = false;
    } 
    if(pwdConfirm.isEmpty) {
      state = false;
    }
    if(pwd != pwdConfirm) {
      state = false;
    }
  }

  void set(bool btnState) => state = btnState;

  bool get() => state;
}

final registerButtonProvider = 
    StateNotifierProvider<RegisterButtonState, bool>((ref) => RegisterButtonState());