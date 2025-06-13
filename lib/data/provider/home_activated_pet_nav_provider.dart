import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeActivatedPetNavState extends StateNotifier<int> {
  HomeActivatedPetNavState() : super(0);

  void set(int value) {
    state = value;
  }

  int get() => state;
}

final homeActivatedPetNavProvider = 
  StateNotifierProvider<HomeActivatedPetNavState, int>((ref) => HomeActivatedPetNavState());