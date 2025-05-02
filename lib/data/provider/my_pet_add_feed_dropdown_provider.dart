import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetAddFeedDropdownState extends StateNotifier<bool> {
  MyPetAddFeedDropdownState() : super(false);

  void set(bool isShow) => state = isShow;

  bool get() => state;
}

final myPetAddFeedDropdownProvider = 
    StateNotifierProvider<MyPetAddFeedDropdownState, bool>((ref) => MyPetAddFeedDropdownState());