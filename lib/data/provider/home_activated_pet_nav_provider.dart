import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeActivatedPetNavState extends StateNotifier<int> {
  HomeActivatedPetNavState() : super(0) {
    _loadPreference();
  }

  static const _preferenceKey = 'homeActivatedPetNav';

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

final homeActivatedPetNavProvider = 
  StateNotifierProvider<HomeActivatedPetNavState, int>((ref) => HomeActivatedPetNavState());