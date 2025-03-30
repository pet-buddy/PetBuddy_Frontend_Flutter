import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/request_my_profile_update_model.dart';

class MyProfileInputState extends StateNotifier<RequestMyProfileUpdateModel> {
  MyProfileInputState() : super(
    RequestMyProfileUpdateModel(
      gender: "", 
      birth: "",
      healthInfo: "",
      phone: "",
    ),
  );

  void set(RequestMyProfileUpdateModel model) => state = model;

  void setGender(String gender) => state.gender = gender;

  void setBirth(String birth) => state.birth = birth;

  void setHealthInfo(String healthInfo) => state.healthInfo = healthInfo;

  void setPhone(String phone) => state.phone = phone;

  RequestMyProfileUpdateModel get() => state;

  String getGender() => state.gender;

  String getBirth() => state.birth;

  String getHealthInfo() => state.healthInfo;

  String getPhone() => state.phone;
}

final myProfileInputProvider = 
    StateNotifierProvider<MyProfileInputState, RequestMyProfileUpdateModel>((ref) => MyProfileInputState());