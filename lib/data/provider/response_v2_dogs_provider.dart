import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResponseV2DogsState extends StateNotifier<List<ResponseV2DogsDetailModel>> {
  ResponseV2DogsState() : super([]) {
    _loadPreference();
  }

  static const _preferenceKey = 'responseV2Dogs';

  void set(List<ResponseV2DogsDetailModel> types) { 
    state = types;
    _savePreference();
  }

  List<ResponseV2DogsDetailModel> get() => state;

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_preferenceKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final dogs = jsonList.map((e) => ResponseV2DogsDetailModel.fromJson(e)).toList();
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

final responseV2DogsProvider = 
  StateNotifierProvider<ResponseV2DogsState, List<ResponseV2DogsDetailModel>>((ref) => ResponseV2DogsState());