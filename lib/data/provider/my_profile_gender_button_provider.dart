import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyProfileGenderButtonState extends StateNotifier<String> {
  MyProfileGenderButtonState() : super("");

  void set(String sex) {
    state = sex;
  }

  String get() {
    return state;
  }
}

final myProfileGenderButtonProvider = 
    StateNotifierProvider<MyProfileGenderButtonState, String>((ref) => MyProfileGenderButtonState());