// import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class HomeActivityHourlyValueListState extends StateNotifier<List<double>> {
  HomeActivityHourlyValueListState() : super([
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
  ]);

  // static const _preferenceKey = 'homeActivityValueList';

  void set(List<double> activityValueList) {
    state = activityValueList;
  }

  List<double> get() => state;

  void add(double elem) {
    state = [...state, elem];
  }

  void remove(double elem) {
    state = state.where((e) => e != elem).toList();
  }

  void removeAt(int index) {
    final newList = [...state]..removeAt(index);
    state = newList;
  }

  void removeMultipleAt(List<int> indices) {
    state = state.asMap()
                 .entries
                 .where((e) => !indices.contains(e.key))
                 .map((e) => e.value)
                 .toList();
  }

  void updateAt(int index, double newValue) {
    final updated = [...state];
    if (index >= 0 && index < updated.length) {
      updated[index] = newValue;
      state = updated;
    }
  }
}

final homeActivityHourlyValueListProvider = 
  StateNotifierProvider<HomeActivityHourlyValueListState, List<double>>((ref) => HomeActivityHourlyValueListState());