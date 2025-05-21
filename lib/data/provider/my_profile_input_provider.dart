import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/request_users_model.dart';

class MyProfileInputState extends StateNotifier<RequestUsersModel> {
  MyProfileInputState() : super(
    RequestUsersModel(
      gender: "", 
      birth: "",
      interest: "",
      phone_number: "",
    ),
  );

  void set(RequestUsersModel model) => state = model;

  void setGender(String gender) => state.gender = gender;

  void setBirth(String birth) => state.birth = birth;

  void setInterest(String interest) => state.interest = interest;

  void setPhoneNumber(String phone_number) => state.phone_number = phone_number;

  RequestUsersModel get() => state;

  String getGender() => state.gender;

  String getBirth() => state.birth;

  String getInterest() => state.interest;

  String getPhoneNumber() => state.phone_number;
}

final myProfileInputProvider = 
    StateNotifierProvider<MyProfileInputState, RequestUsersModel>((ref) => MyProfileInputState());