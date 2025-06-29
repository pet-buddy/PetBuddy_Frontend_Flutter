import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/request_update_dog_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestUpdateDogState extends StateNotifier<RequestUpdateDogModel> {
  RequestUpdateDogState() : super(
    RequestUpdateDogModel(
      pet_name: '',
      pet_size: '',
      division2_code: '',
      pet_gender: '',
      neuter_yn: null,
      feed_id: -1,
      feed_time: [],
      pet_birth: '',
      food_remain_grade: '',
    ),
  ) {
    _loadPreference();
  }  

  static const _preferenceKey = 'requestUpdateDog';

  void set(RequestUpdateDogModel model) {
    state = model;
    _savePreference();
  }

  void setPetName(String petName) {
    state.pet_name = petName;
    // state = state.copyWith(pet_name: petName);
    _savePreference();
  }

  void setPetSize(String petSize) {
    state.pet_size = petSize;
    // state = state.copyWith(pet_size: petSize);
    _savePreference();
  }

  void setDivision2Code(String division2Code) {
    state.division2_code = division2Code;
    // state = state.copyWith(division2_code: division2Code);
    _savePreference();
  }

  void setPetGender(String petGender) {
    state.pet_gender = petGender;
    // state = state.copyWith(pet_gender: petGender);
    _savePreference();
  }

  void setNeuterYn(bool? neuterYn) {
    state.neuter_yn = neuterYn;
    // state = state.copyWith(neuter_yn: neuterYn);
    _savePreference();
  }

  void setFeedId(int feedId) {
    state.feed_id = feedId;
    // state = state.copyWith(feed_id: feedId);
    _savePreference();
  }

  void setFeedTime(List<String> feedTime) {
    state.feed_time = feedTime;
    // state = state.copyWith(feed_time: feedTime);
    _savePreference();
  }

  void setPetBirth(String petBirth) {
    state.pet_birth = petBirth;
    // state = state.copyWith(pet_birth: petBirth);
    _savePreference();
  }

  void setFoodRemainGrade(String foodRemainGrade) {
    state.food_remain_grade = foodRemainGrade;
    // state = state.copyWith(food_remain_grade: foodRemainGrade);
    _savePreference();
  }

  RequestUpdateDogModel get() => state;

  String getPetName() => state.pet_name;

  String getPetSize() => state.pet_size;

  String getDivision2Code() => state.division2_code;

  String getPetGender() => state.pet_gender;

  bool? getNeuterYn() => state.neuter_yn;

  int getFeedId() => state.feed_id;

  List<String> getFeedTime() => state.feed_time;

  String getPetBirth() => state.pet_birth;

  String getFoodRemainGrade() => state.food_remain_grade;

  Future<void> _loadPreference() async {
    if (!kIsWeb) return;
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_preferenceKey);
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      state = RequestUpdateDogModel.fromJson(jsonMap);
    }
  }

  Future<void> _savePreference() async {
    if (!kIsWeb) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_preferenceKey, jsonEncode(state.toJson()));
  }
}

final requestUpdateDogProvider = 
    StateNotifierProvider<RequestUpdateDogState, RequestUpdateDogModel>((ref) => RequestUpdateDogState());