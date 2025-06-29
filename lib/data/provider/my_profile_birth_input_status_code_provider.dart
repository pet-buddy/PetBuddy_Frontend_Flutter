import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileBirthInputStatusCodeState extends StateNotifier<String> {
  MyProfileBirthInputStatusCodeState() : super(ProjectConstant.INPUT_INIT) {
    _loadPreference();
  }

  static const _preferenceKey = 'myProfileBirthInputStatusCode';

  void set(String code) {
    state = code;
    _savePreference();
  }

  String get() {
    return state;
  }

  Future<void> _loadPreference() async {
    if(!kIsWeb) return;

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_preferenceKey) ?? ProjectConstant.INPUT_INIT;
    state = saved;
  }

  Future<void> _savePreference() async {
    if(!kIsWeb) return;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_preferenceKey, state);
  }
}

final myProfileBirthInputStatusCodeProvider = 
    StateNotifierProvider<MyProfileBirthInputStatusCodeState, String>((ref) => MyProfileBirthInputStatusCodeState());