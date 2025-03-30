import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyProfileHealthInfoButtonState extends StateNotifier<int> {
  MyProfileHealthInfoButtonState() : super(-1);

  void set(int index) {
    state = index;
  }

  int get() {
    return state;
  }
}

final myProfileHealthInfoButtonProvider = 
    StateNotifierProvider<MyProfileHealthInfoButtonState, int>((ref) => MyProfileHealthInfoButtonState());