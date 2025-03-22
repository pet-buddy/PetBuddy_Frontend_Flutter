import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailLoginButtonState extends StateNotifier<bool> {
  EmailLoginButtonState() : super(false);

  void activate(String email, String pwd) {
    if(email.isNotEmpty && pwd.isNotEmpty) {
      state = true;
    } else {
      state = false;
    }
  }
}

final emailLoginButtonProvider = 
    StateNotifierProvider<EmailLoginButtonState, bool>((ref) => EmailLoginButtonState());