import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResponsePooDailyStatusState extends StateNotifier<ResponsePooDailyStatusModel> {
  ResponsePooDailyStatusState() : super(
    ResponsePooDailyStatusModel(
      poop_date: "",
      poop_url: "",
      poop_score_total: 0,
      poop_score_color: 0,
      poop_score_moisture: 0,
      poop_score_parasite: 0,
    )
  ) {
    _loadPreference();
  }

  static const _preferenceKey = 'responsePooDailyStatus';

  void set(ResponsePooDailyStatusModel responsePooDailyStatusModel) {
    state = responsePooDailyStatusModel;
    _savePreference();
  }

  ResponsePooDailyStatusModel get() => state;

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_preferenceKey);

    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      state = ResponsePooDailyStatusModel.fromJson(jsonMap);
    }
  }

  Future<void> _savePreference() async {
    if(!kIsWeb) return;
    
    final prefs = await SharedPreferences.getInstance();
    final jsonMap = state.toJson();
    await prefs.setString(_preferenceKey, jsonEncode(jsonMap));
  }
}

final responsePooDailyStatusProvider = 
  StateNotifierProvider<ResponsePooDailyStatusState, ResponsePooDailyStatusModel>((ref) => ResponsePooDailyStatusState());