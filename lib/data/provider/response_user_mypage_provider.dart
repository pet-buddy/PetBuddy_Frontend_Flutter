import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/response_user_mypage_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResponseUserMypageState extends StateNotifier<ResponseUserMypageModel> {
  ResponseUserMypageState() : super(ResponseUserMypageModel(
    user_id: -1,
    user_name: null,
    email: "",
    user_password: "",
    gender: null,
    interest: null,
    sign_route: null,
    address: null,
    remark: null,
    birth: null,
    user_steps: null,
    created_at: "",
    updated_at: null,
    createdAt: "",
    updatedAt: null,
  )) {
    _loadPreference();
  }

  static const _preferenceKey = 'responseUserMypage';

  void set(ResponseUserMypageModel responseUserMypageModel) {
    state = responseUserMypageModel;
    _savePreference();
  }

  ResponseUserMypageModel get() {
    return state;
  }

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_preferenceKey);

    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      state = ResponseUserMypageModel.fromJson(jsonMap);
    }
  }

  Future<void> _savePreference() async {
    if(!kIsWeb) return;
    
    final prefs = await SharedPreferences.getInstance();
    final jsonMap = state.toJson();
    await prefs.setString(_preferenceKey, jsonEncode(jsonMap));
  }
}

final responseUserMypageProvider = 
    StateNotifierProvider<ResponseUserMypageState, ResponseUserMypageModel>((ref) => ResponseUserMypageState());