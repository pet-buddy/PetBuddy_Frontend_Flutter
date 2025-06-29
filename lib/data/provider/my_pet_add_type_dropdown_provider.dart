import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPetAddTypeDropdownState extends StateNotifier<bool> {
  MyPetAddTypeDropdownState() : super(false) {
    _loadPreference();
  }

  static const _preferenceKey = 'myPetAddTypeDropdown';

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

final myPetAddTypeDropdownProvider = 
    StateNotifierProvider<MyPetAddTypeDropdownState, bool>((ref) => MyPetAddTypeDropdownState());