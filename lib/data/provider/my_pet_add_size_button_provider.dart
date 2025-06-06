import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetAddSizeButtonState extends StateNotifier<String> {
  MyPetAddSizeButtonState() : super("");

  void set(String size) {
    state = size;
  }

  String get() {
    return state;
  }
}

final myPetAddSizeButtonProvider = 
    StateNotifierProvider<MyPetAddSizeButtonState, String>((ref) => MyPetAddSizeButtonState());