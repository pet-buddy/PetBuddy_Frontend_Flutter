import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPetAddFeedTimeListState extends StateNotifier<List<String>> {
  MyPetAddFeedTimeListState() : super([]) {
    _loadPreference();
  }

  static const _preferenceKey = 'myPetAddFeedTimeList';

  void set(List<String> timeList) {
    state = timeList;
    _savePreference();
  }

  List<String> get() => state;

  void add(String elem) {
    state = [...state, elem];
    _savePreference();
  }

  void remove(String elem) {
    state = state.where((e) => e != elem).toList();
    _savePreference();
  }

  void removeAt(int index) {
    final newList = [...state]..removeAt(index);
    state = newList;
    _savePreference();
  }

  void removeMultipleAt(List<int> indices) {
    state = state.asMap()
                 .entries
                 .where((e) => !indices.contains(e.key))
                 .map((e) => e.value)
                 .toList();

    _savePreference();
  }

  void updateAt(int index, String newValue) {
    final updated = [...state];
    if (index >= 0 && index < updated.length) {
      updated[index] = newValue;
      state = updated;
    }
    _savePreference();
  }

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

final myPetAddFeedTimeListProvider = 
  StateNotifierProvider<MyPetAddFeedTimeListState, List<String>>((ref) => MyPetAddFeedTimeListState());