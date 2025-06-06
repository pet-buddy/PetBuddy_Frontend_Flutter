import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';

class MyPetAddNameInputStatusCodeState extends StateNotifier<String> {
  MyPetAddNameInputStatusCodeState() : super(ProjectConstant.INPUT_INIT);

  void set(String code) {
    state = code;
  }

  String get() {
    return state;
  }
}

final myPetAddNameInputStatusCodeProvider = 
    StateNotifierProvider<MyPetAddNameInputStatusCodeState, String>((ref) => MyPetAddNameInputStatusCodeState());