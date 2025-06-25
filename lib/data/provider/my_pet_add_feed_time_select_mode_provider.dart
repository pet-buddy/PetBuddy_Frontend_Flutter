import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetAddFeedTimeSelectModeState extends StateNotifier<String> {
  MyPetAddFeedTimeSelectModeState() : super("");

  void set(String mode) {
    state = mode;
  }

  String get() {
    return state;
  }
}

final myPetAddFeedTimeSelectModeProvider = 
    StateNotifierProvider<MyPetAddFeedTimeSelectModeState, String>((ref) => MyPetAddFeedTimeSelectModeState());