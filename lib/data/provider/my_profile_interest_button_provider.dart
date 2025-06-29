import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileInterestButtonState extends StateNotifier<int> {
  MyProfileInterestButtonState() : super(-1) {
    _loadPreference();
  }

  static const _preferenceKey = 'myProfileInterestButton';

  void set(int index) {
    state = index;
    _savePreference();
  }

  int get() {
    return state;
  }

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getInt(_preferenceKey) ?? -1;
    state = saved;
  }

  Future<void> _savePreference() async {
    if(!kIsWeb) return;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_preferenceKey, state);
  }
}

final myProfileInterestButtonProvider = 
    StateNotifierProvider<MyProfileInterestButtonState, int>((ref) => MyProfileInterestButtonState());