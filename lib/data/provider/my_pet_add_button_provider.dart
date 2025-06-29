import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPetAddButtonState extends StateNotifier<bool> {
  MyPetAddButtonState() : super(false) {
    _loadPreference();
  }

  static const _preferenceKey = 'myPetAddButton';

  void activate(RequestNewDogModel requestNewDogModel) {
    final String petName = requestNewDogModel.pet_name;
    final String petSize = requestNewDogModel.pet_size;
    final String petType = requestNewDogModel.division2_code;
    final String petGender = requestNewDogModel.pet_gender;
    final bool? neuterYn = requestNewDogModel.neuter_yn;
    final int feedId = requestNewDogModel.feed_id;
    final List<String> feedTime = requestNewDogModel.feed_time;
    final String petBirth = requestNewDogModel.pet_birth;

    if(petName.isNotEmpty 
        && petSize.isNotEmpty
        && petType.isNotEmpty
        && petGender.isNotEmpty
        && neuterYn != null
        && feedId != -1
        && feedTime.isNotEmpty
        && (petBirth.isNotEmpty && petBirth.length >= 10)) {
      state = true;
    } else {
      state = false;
    }
    
    _savePreference();
  }

  void set(bool btnState) { 
    state = btnState;
    _savePreference();
  }

  bool get() => state;

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

final myPetAddButtonProvider = 
    StateNotifierProvider<MyPetAddButtonState, bool>((ref) => MyPetAddButtonState());