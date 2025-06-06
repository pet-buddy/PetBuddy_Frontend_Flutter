import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetAddNeuterButtonState extends StateNotifier<String> {
  MyPetAddNeuterButtonState() : super("");

  void set(String size) {
    state = size;
  }

  String get() {
    return state;
  }
}

final myPetAddNeuterButtonProvider = 
    StateNotifierProvider<MyPetAddNeuterButtonState, String>((ref) => MyPetAddNeuterButtonState());