import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResponseV2UserMypageState extends StateNotifier<ResponseV2UserMypageModel> {
  ResponseV2UserMypageState() : super(ResponseV2UserMypageModel(
    user_id: -1,
    user_name: null,
    user_slug: null,
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

  static const _preferenceKey = 'responseV2UserMypage';

  void set(ResponseV2UserMypageModel responseV2UserMypageModel) {
    state = responseV2UserMypageModel;
    _savePreference();
  }

  ResponseV2UserMypageModel get() {
    return state;
  }

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_preferenceKey);

    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      state = ResponseV2UserMypageModel.fromJson(jsonMap);
    }
  }

  Future<void> _savePreference() async {
    if(!kIsWeb) return;
    
    final prefs = await SharedPreferences.getInstance();
    final jsonMap = state.toJson();
    await prefs.setString(_preferenceKey, jsonEncode(jsonMap));
  }
}

final responseV2UserMypageProvider = 
    StateNotifierProvider<ResponseV2UserMypageState, ResponseV2UserMypageModel>((ref) => ResponseV2UserMypageState());