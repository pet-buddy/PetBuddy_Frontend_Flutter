import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';

class MyPetAddButtonState extends StateNotifier<bool> {
  MyPetAddButtonState() : super(false);

  void activate(RequestNewDogModel requestNewDogModel) {
    final String petName = requestNewDogModel.pet_name;
    final String petSize = requestNewDogModel.pet_size;
    final String petType = requestNewDogModel.division2_code;
    final String petGender = requestNewDogModel.pet_gender;
    final String neuterYn = requestNewDogModel.neuter_yn;
    final int feedId = requestNewDogModel.feed_id;
    final List<String> feedTime = requestNewDogModel.feed_time;
    final String petBirth = requestNewDogModel.pet_birth;

    if(petName.isNotEmpty 
        && petSize.isNotEmpty
        && petType.isNotEmpty
        && petGender.isNotEmpty
        && neuterYn.isNotEmpty
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

final myPetAddButtonProvider = 
    StateNotifierProvider<MyPetAddButtonState, bool>((ref) => MyPetAddButtonState());