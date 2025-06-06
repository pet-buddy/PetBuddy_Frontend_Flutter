import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetAddGenderButtonState extends StateNotifier<String> {
  MyPetAddGenderButtonState() : super("");

  void set(String size) {
    state = size;
  }

  String get() {
    return state;
  }
}

final myPetAddGenderButtonProvider = 
    StateNotifierProvider<MyPetAddGenderButtonState, String>((ref) => MyPetAddGenderButtonState());