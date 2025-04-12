import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyProfileSexButtonState extends StateNotifier<String> {
  MyProfileSexButtonState() : super("");

  void set(String sex) {
    state = sex;
  }

  String get() {
    return state;
  }
}

final myProfileSexButtonProvider = 
    StateNotifierProvider<MyProfileSexButtonState, String>((ref) => MyProfileSexButtonState());