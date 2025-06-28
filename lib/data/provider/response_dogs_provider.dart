import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/response_dogs_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResponseDogsState extends StateNotifier<List<ResponseDogsDetailModel>> {
  ResponseDogsState() : super([]) {
    _loadPreference();
  }

  static const _preferenceKey = 'responseDogs';

  void set(List<ResponseDogsDetailModel> types) { 
    state = types;
    _savePreference();
  }

  List<ResponseDogsDetailModel> get() => state;

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_preferenceKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final dogs = jsonList.map((e) => ResponseDogsDetailModel.fromJson(e)).toList();
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

final responseDogsProvider = 
  StateNotifierProvider<ResponseDogsState, List<ResponseDogsDetailModel>>((ref) => ResponseDogsState());