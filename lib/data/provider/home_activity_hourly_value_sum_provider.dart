import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeActivityHourlyValueSumState extends StateNotifier<double> {
  HomeActivityHourlyValueSumState() : super(0.0) {
    _loadPreference();
  }

  static const _preferenceKey = 'homeActivityHourlyValueSum';

  void set(double value) {
    state = value;
    _savePreference();
  }

  double get() => state;

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getDouble(_preferenceKey) ?? 0.0;
    state = saved;
  }

  Future<void> _savePreference() async {
    if(!kIsWeb) return;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_preferenceKey, state);
  }
}

final homeActivityHourlyValueSumProvider = 
  StateNotifierProvider<HomeActivityHourlyValueSumState, double>((ref) => HomeActivityHourlyValueSumState());