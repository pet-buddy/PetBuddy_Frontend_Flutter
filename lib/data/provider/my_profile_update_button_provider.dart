import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/request_users_model.dart';

class MyProfileUpdateButtonState extends StateNotifier<bool> {
  MyProfileUpdateButtonState() : super(false);

  void activate(RequestUsersModel requestUsersModel) {
    final sex = requestUsersModel.sex; 
    final birth = requestUsersModel.birth;
    final interest = requestUsersModel.interest;
    final phone_number = requestUsersModel.phone_number;
    
    if(sex.isNotEmpty 
        && (birth.isNotEmpty && birth.length >= 10)
        && interest.isNotEmpty
        && (phone_number.isNotEmpty && phone_number.length >= 13)) {
      state = true;
    } else {
      state = false;
    }
  }
}

final myProfileUpdateButtonProvider = 
    StateNotifierProvider<MyProfileUpdateButtonState, bool>((ref) => MyProfileUpdateButtonState());