import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/response_activity_hourly_status_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResponseActivityHourlyStatusListState extends StateNotifier<List<ResponseActivityHourlyStatusModel>> {
  ResponseActivityHourlyStatusListState() : super([]) {
    _loadPreference();
  }

  static const _preferenceKey = 'responseActivityHourlyStatusListState';

  void set(List<ResponseActivityHourlyStatusModel> types) { 
    state = types;
    _savePreference();
  }

  List<ResponseActivityHourlyStatusModel> get() => state;

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_preferenceKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final dogs = jsonList.map((e) => ResponseActivityHourlyStatusModel.fromJson(e)).toList();
      state = dogs;
    }
  }

  Future<void> _savePreference() async {
    if(!kIsWeb) return;
    
    final prefs = await SharedPreferences.getInstance();
    final jsonList = state.map((e) => e.toJson()).toList();
    await prefs.setString(_preferenceKey, jsonEncode(jsonList));
  }
}

final responseActivityHourlyStatusListProvider = 
  StateNotifierProvider<ResponseActivityHourlyStatusListState, List<ResponseActivityHourlyStatusModel>>((ref) => ResponseActivityHourlyStatusListState());