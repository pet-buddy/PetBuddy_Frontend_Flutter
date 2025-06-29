import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPetAddFeedTimeDeleteListState extends StateNotifier<List<int>> {
  MyPetAddFeedTimeDeleteListState() : super([]) {
    _loadPreference();
  }

  static const _preferenceKey = 'myPetAddFeedTimeDeleteList';

  void set(List<int> deleteTimeList) {
    state = deleteTimeList;
    _savePreference();
  }

  List<int> get() => state;

  void add(int elem) {
    state = [...state, elem];
    _savePreference();
  }

  void remove(int elem) {
    state = state.where((e) => e != elem).toList();
    _savePreference();
  }

  void removeAt(int index) {
    final newList = [...state]..removeAt(index);
    state = newList;
    _savePreference();
  }

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_preferenceKey) ?? [];
    state = saved.map((e) => int.tryParse(e) ?? -1).where((e) => e != -1).toList();
  }

  Future<void> _savePreference() async {
    if(!kIsWeb) return;
    
    final prefs = await SharedPreferences.getInstance();
    final savedList = state.map((e) => e.toString()).toList();
    await prefs.setStringList(_preferenceKey, savedList);
  }
}

final myPetAddFeedTimeDeleteListProvider = 
  StateNotifierProvider<MyPetAddFeedTimeDeleteListState, List<int>>((ref) => MyPetAddFeedTimeDeleteListState());