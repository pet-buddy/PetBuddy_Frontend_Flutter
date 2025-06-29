import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPetAddFeedDropdownState extends StateNotifier<bool> {
  MyPetAddFeedDropdownState() : super(false) {
    _loadPreference();
  }

  static const _preferenceKey = 'myPetAddFeedDropdown';

  void set(bool isShow) {
    state = isShow;
    _savePreference();
  }

  bool get() => state;

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool(_preferenceKey) ?? false;
    state = saved;
  }

  Future<void> _savePreference() async {
    if(!kIsWeb) return;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_preferenceKey, state);
  }
}

final myPetAddFeedDropdownProvider = 
    StateNotifierProvider<MyPetAddFeedDropdownState, bool>((ref) => MyPetAddFeedDropdownState());