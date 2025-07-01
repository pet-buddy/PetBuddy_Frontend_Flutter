import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/data/model/request_users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileUpdateButtonState extends StateNotifier<bool> {
  MyProfileUpdateButtonState() : super(false) {
    _loadPreference();
  }

  static const _preferenceKey = 'myProfileUpdateButton';

  void activate(RequestUsersModel requestUsersModel) {
    final sex = requestUsersModel.gender; 
    final birth = requestUsersModel.birth;
    final interest = requestUsersModel.interest;
    final phone_number = requestUsersModel.phone_number;
    
    if(sex.isNotEmpty 
        && (birth.isNotEmpty && birth.length >= 10 && fnValidateBirthFormat(birth))
        && interest.isNotEmpty
        && (phone_number.isNotEmpty && phone_number.length >= 13)) {
      state = true;
    } else {
      state = false;
    }

    _savePreference();
  }

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

final myProfileUpdateButtonProvider = 
    StateNotifierProvider<MyProfileUpdateButtonState, bool>((ref) => MyProfileUpdateButtonState());