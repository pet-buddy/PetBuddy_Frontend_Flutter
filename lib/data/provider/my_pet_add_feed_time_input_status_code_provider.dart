import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';

class MyPetAddFeedTimeInputStatusCodeState extends StateNotifier<String> {
  MyPetAddFeedTimeInputStatusCodeState() : super(ProjectConstant.INPUT_INIT);

  void set(String code) {
    state = code;
  }

  String get() {
    return state;
  }
}

final myPetAddFeedTimeInputStatusCodeProvider = 
    StateNotifierProvider<MyPetAddFeedTimeInputStatusCodeState, String>((ref) => MyPetAddFeedTimeInputStatusCodeState());