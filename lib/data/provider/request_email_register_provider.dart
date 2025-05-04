import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/request_email_register_model.dart';

class RequestEmailRegisterState extends StateNotifier<RequestEmailRegisterModel> {
  RequestEmailRegisterState() : super(
    RequestEmailRegisterModel(
      name: "",
      email: "", 
      password: ""
    ),
  );

  void set(RequestEmailRegisterModel model) => state = model;

  void setName(String name) => state.name = name;
 
  void setEmail(String email) => state.email = email;

  void setPwd(String pwd) => state.password = pwd;

  RequestEmailRegisterModel get() => state;

  String getName() => state.name;

  String getEmail() => state.email;

  String getPwd() => state.password;
}

final requestEmailRegisterProvider = 
    StateNotifierProvider<RequestEmailRegisterState, RequestEmailRegisterModel>((ref) => RequestEmailRegisterState());