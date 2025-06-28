import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/request_update_dog_model.dart';

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
  );

  void set(RequestUpdateDogModel model) => state = model;

  void setPetName(String petName) => state.pet_name = petName;

  void setPetSize(String petSize) => state.pet_size = petSize;

  void setDivision2Code(String division2Code) => state.division2_code = division2Code;

  void setPetGender(String petGender) => state.pet_gender = petGender;

  void setNeuterYn(bool? neuterYn) => state.neuter_yn = neuterYn;

  void setFeedId(int feedId) => state.feed_id = feedId;

  void setFeedTime(List<String> feedTime) => state.feed_time = feedTime;

  void setPetBirth(String petBirth) => state.pet_birth = petBirth;

  void setFoodRemainGrade(String foodRemainGrade) => state.food_remain_grade = foodRemainGrade;

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
}

final requestUpdateDogProvider = 
    StateNotifierProvider<RequestUpdateDogState, RequestUpdateDogModel>((ref) => RequestUpdateDogState());