import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetAddFeedAmountButtonState extends StateNotifier<String> {
  MyPetAddFeedAmountButtonState() : super("");

  void set(String size) {
    state = size;
  }

  String get() {
    return state;
  }
}

final myPetAddFeedAmountButtonProvider = 
    StateNotifierProvider<MyPetAddFeedAmountButtonState, String>((ref) => MyPetAddFeedAmountButtonState());