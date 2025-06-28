import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavState extends StateNotifier<int> {
  BottomNavState() : super(0) {
    _loadPreference();
  }

  static const _preferenceKey = 'bottomNav';

  void set(int value) {
    state = value;
    _savePreference();
  }

  int get() => state;

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getInt(_preferenceKey) ?? 0;
    state = saved;
  }

  Future<void> _savePreference() async {
    if(!kIsWeb) return;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_preferenceKey, state);
  }
}

final bottomNavProvider = 
  StateNotifierProvider<BottomNavState, int>((ref) => BottomNavState());