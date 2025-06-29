import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/request_users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestUsersState extends StateNotifier<RequestUsersModel> {
  RequestUsersState() : super(
    RequestUsersModel(
      gender: "", 
      birth: "",
      interest: "",
      phone_number: "",
    ),
  ) {
    _loadPreference();
  }

  static const _preferenceKey = 'requestUsers';

  void set(RequestUsersModel model) {
    state = model;
    _savePreference();
  }

  void setGender(String gender) {
    // state.gender = gender;
    state = state.copyWith(gender: gender);
    _savePreference();
  }

  void setBirth(String birth) {
    // state.birth = birth;
    state = state.copyWith(birth: birth);
    _savePreference();
  }

  void setInterest(String interest) {
    // state.interest = interest;
    state = state.copyWith(interest: interest);
    _savePreference();
  }

  void setPhoneNumber(String phone_number) {
    // state.phone_number = phone_number;
    state = state.copyWith(phone_number: phone_number);
    _savePreference();
  }

  RequestUsersModel get() => state;

  String getGender() => state.gender;

  String getBirth() => state.birth;

  String getInterest() => state.interest;

  String getPhoneNumber() => state.phone_number;

  Future<void> _loadPreference() async {
    if (!kIsWeb) return;
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_preferenceKey);
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      state = RequestUsersModel.fromJson(jsonMap);
    }
  }

  Future<void> _savePreference() async {
    if (!kIsWeb) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_preferenceKey, jsonEncode(state.toJson()));
  }
}

final requestUsersProvider = 
    StateNotifierProvider<RequestUsersState, RequestUsersModel>((ref) => RequestUsersState());