import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetAddTypeDropdownState extends StateNotifier<bool> {
  MyPetAddTypeDropdownState() : super(false);

  void set(bool isShow) => state = isShow;

  bool get() => state;
}

final myPetAddTypeDropdownProvider = 
    StateNotifierProvider<MyPetAddTypeDropdownState, bool>((ref) => MyPetAddTypeDropdownState());