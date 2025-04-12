import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/request_users_model.dart';

class MyProfileInputState extends StateNotifier<RequestUsersModel> {
  MyProfileInputState() : super(
    RequestUsersModel(
      sex: "", 
      birth: "",
      interest: "",
      phone_number: "",
    ),
  );

  void set(RequestUsersModel model) => state = model;

  void setSex(String sex) => state.sex = sex;

  void setBirth(String birth) => state.birth = birth;

  void setInterest(String interest) => state.interest = interest;

  void setPhoneNumber(String phone_number) => state.phone_number = phone_number;

  RequestUsersModel get() => state;

  String getSex() => state.sex;

  String getBirth() => state.birth;

  String getInterest() => state.interest;

  String getPhoneNumber() => state.phone_number;
}

final myProfileInputProvider = 
    StateNotifierProvider<MyProfileInputState, RequestUsersModel>((ref) => MyProfileInputState());