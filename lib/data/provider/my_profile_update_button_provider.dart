import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/request_my_profile_update_model.dart';

class MyProfileUpdateButtonState extends StateNotifier<bool> {
  MyProfileUpdateButtonState() : super(false);

  void activate(RequestMyProfileUpdateModel requestMyProfileUpdateModel) {
    final gender = requestMyProfileUpdateModel.gender; 
    final birth = requestMyProfileUpdateModel.birth;
    final healthInfo = requestMyProfileUpdateModel.healthInfo;
    final phone = requestMyProfileUpdateModel.phone;
    
    if(gender.isNotEmpty 
        && (birth.isNotEmpty && birth.length >= 10)
        && healthInfo.isNotEmpty
        && (phone.isNotEmpty && phone.length >= 13)) {
      state = true;
    } else {
      state = false;
    }
  }
}

final myProfileUpdateButtonProvider = 
    StateNotifierProvider<MyProfileUpdateButtonState, bool>((ref) => MyProfileUpdateButtonState());