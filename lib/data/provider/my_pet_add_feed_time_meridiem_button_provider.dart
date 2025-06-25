import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetAddFeedTimeMeridiemButtonState extends StateNotifier<String> {
  MyPetAddFeedTimeMeridiemButtonState() : super("");

  void set(String meridiem) {
    state = meridiem;
  }

  String get() {
    return state;
  }
}

final myPetAddFeedTimeMeridiemButtonProvider = 
    StateNotifierProvider<MyPetAddFeedTimeMeridiemButtonState, String>((ref) => MyPetAddFeedTimeMeridiemButtonState());