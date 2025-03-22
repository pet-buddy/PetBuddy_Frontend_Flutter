import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/request_email_login_model.dart';

class EmailLoginInputState extends StateNotifier<RequestEmailLoginModel> {
  EmailLoginInputState() : super(
    RequestEmailLoginModel(
      email: "", 
      password: ""
    ),
  );

  void set(RequestEmailLoginModel model) => state = model;

  void setEmail(String email) => state.email = email;

  void setPwd(String pwd) => state.password = pwd;

  RequestEmailLoginModel get() => state;

  String getEmail() => state.email;

  String getPwd() => state.password;
}

final emailLoginInputProvider = 
    StateNotifierProvider<EmailLoginInputState, RequestEmailLoginModel>((ref) => EmailLoginInputState());