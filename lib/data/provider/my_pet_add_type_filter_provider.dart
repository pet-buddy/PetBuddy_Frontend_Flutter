import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPetAddTypeFilterState extends StateNotifier<List<String>> {
  MyPetAddTypeFilterState() : super([]) {
    _loadPreference();
  }

  static const _preferenceKey = 'myPetAddTypeFilter';

  void set(List<String> types) {
    state = types;
    _savePreference();
  }

  List<String> get() => state;

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_preferenceKey) ?? [];
    state = saved;
  }

  Future<void> _savePreference() async {
    if(!kIsWeb) return;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_preferenceKey, state);
  }
}

final myPetAddTypeFilterProvider = 
  StateNotifierProvider<MyPetAddTypeFilterState, List<String>>((ref) => MyPetAddTypeFilterState());