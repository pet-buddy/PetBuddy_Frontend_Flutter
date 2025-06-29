import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPetAddNameInputStatusCodeState extends StateNotifier<String> {
  MyPetAddNameInputStatusCodeState() : super(ProjectConstant.INPUT_INIT) {
    _loadPreference();
  }

  static const _preferenceKey = 'myPetAddNameInputStatusCode';

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

final myPetAddNameInputStatusCodeProvider = 
    StateNotifierProvider<MyPetAddNameInputStatusCodeState, String>((ref) => MyPetAddNameInputStatusCodeState());