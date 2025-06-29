import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPetAddFeedTimeMeridiemButtonState extends StateNotifier<String> {
  MyPetAddFeedTimeMeridiemButtonState() : super("") {
    _loadPreference();
  }

  static const _preferenceKey = 'myPetAddFeedTimeMeridiemButton';

  void set(String meridiem) {
    state = meridiem;
    _savePreference();
  }

  String get() {
    return state;
  }

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_preferenceKey) ?? "";
    state = saved;
  }

  Future<void> _savePreference() async {
    if(!kIsWeb) return;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_preferenceKey, state);
  }
}

final myPetAddFeedTimeMeridiemButtonProvider = 
    StateNotifierProvider<MyPetAddFeedTimeMeridiemButtonState, String>((ref) => MyPetAddFeedTimeMeridiemButtonState());