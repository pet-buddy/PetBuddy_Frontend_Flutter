import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPetUpdateButtonState extends StateNotifier<bool> {
  MyPetUpdateButtonState() : super(false) {
    _loadPreference();
  }

  static const _preferenceKey = 'myPetUpdateButton';

  void activate(RequestUpdateDogModel requestUpdateDogModel) {
    final String petName = requestUpdateDogModel.pet_name;
    final String petSize = requestUpdateDogModel.pet_size;
    final String petType = requestUpdateDogModel.division2_code;
    final String petGender = requestUpdateDogModel.pet_gender;
    final bool? neuterYn = requestUpdateDogModel.neuter_yn;
    final int feedId = requestUpdateDogModel.feed_id;
    final List<String> feedTime = requestUpdateDogModel.feed_time;
    final String petBirth = requestUpdateDogModel.pet_birth;

    debugPrint(requestUpdateDogModel.toJson().toString());

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

final myPetUpdateButtonProvider = 
    StateNotifierProvider<MyPetUpdateButtonState, bool>((ref) => MyPetUpdateButtonState());