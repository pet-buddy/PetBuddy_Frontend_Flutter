import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavState extends StateNotifier<int> {
  BottomNavState() : super(0);

  void set(int value) {
    state = value;
  }

  int get() => state;
}

final bottomNavProvider = 
  StateNotifierProvider<BottomNavState, int>((ref) => BottomNavState());