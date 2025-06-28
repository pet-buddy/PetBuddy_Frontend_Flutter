import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';

class MyPetUpdateButtonState extends StateNotifier<bool> {
  MyPetUpdateButtonState() : super(false);

  void activate(RequestUpdateDogModel requestUpdateDogModel) {
    final String petName = requestUpdateDogModel.pet_name;
    final String petSize = requestUpdateDogModel.pet_size;
    final String petType = requestUpdateDogModel.division2_code;
    final String petGender = requestUpdateDogModel.pet_gender;
    final bool? neuterYn = requestUpdateDogModel.neuter_yn;
    final int feedId = requestUpdateDogModel.feed_id;
    final List<String> feedTime = requestUpdateDogModel.feed_time;
    final String petBirth = requestUpdateDogModel.pet_birth;

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
  }

  void set(bool btnState) => state = btnState;

  bool get() => state;
}

final myPetUpdateButtonProvider = 
    StateNotifierProvider<MyPetUpdateButtonState, bool>((ref) => MyPetUpdateButtonState());