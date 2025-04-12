import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyProfileInterestButtonState extends StateNotifier<int> {
  MyProfileInterestButtonState() : super(-1);

  void set(int index) {
    state = index;
  }

  int get() {
    return state;
  }
}

final myProfileInterestButtonProvider = 
    StateNotifierProvider<MyProfileInterestButtonState, int>((ref) => MyProfileInterestButtonState());