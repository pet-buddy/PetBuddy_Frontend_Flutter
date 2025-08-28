import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:petbuddy_frontend_flutter/common/const/sentence.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
import 'package:petbuddy_frontend_flutter/common/widget/dialog/alert_dialog.dart';
// import 'package:petbuddy_frontend_flutter/common/widget/dialog/loading_dialog.dart';
import 'package:petbuddy_frontend_flutter/data/model/response_dogs_detail_model.dart';
import 'package:petbuddy_frontend_flutter/data/model/response_dogs_model.dart';
import 'package:petbuddy_frontend_flutter/data/model/response_user_mypage_model.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
import 'package:petbuddy_frontend_flutter/data/repository/pet_repository.dart';
import 'package:petbuddy_frontend_flutter/data/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerUtils {
  
  static Future<bool> fnGetUserMypageExec(WidgetRef ref, BuildContext context) async {
    bool result = false;

    try {
      final response = await ref.read(userRepositoryProvider).requestUserMypageRepository();

      // debugPrint("========== Get User Mypage Response =========");
      // debugPrint(response.toString());

      if(response.response_code == 200) {
        ResponseUserMypageModel responseUserMypageModel = ResponseUserMypageModel.fromJson(response.data!);
        // 사용자 정보 세팅
        ref.read(responseUserMypageProvider.notifier).set(responseUserMypageModel);
        // 조회 결과 
        result = true;
      } else {
        if(!context.mounted) return result;
        // 에러 알림창
        showAlertDialog(
          context: context, 
          middleText: "사용자 정보 조회에 실패했습니다.\n${response.response_message}"
        );
        return result;
      }
    } on DioException catch(e) {
      // debugPrint("========== Request User Mypage Exception ==========");
      // debugPrint(e.toString());

      // 에러 알림창
      if(!context.mounted) return result;
      showAlertDialog(
        context: context, 
        middleText: '사용자 정보 요청에 실패했습니다.\n${Sentence.SERVER_ERR}',
      );
    }

    return result;
  }


  // TODO : 반려동물 정보 세팅

  // TODO : 홈 화면 정보 세팅

  // ########################################
  // 반려동물 조회
  // ########################################
  static Future<bool> fnGetDogsExec(WidgetRef ref, BuildContext context) async {
    bool result = false;

    try {
      // 로딩 시작
      // showLoadingDialog(context: context);

      final response = await ref.read(petRepositoryProvider).requestDogsRepository();

      if(response.response_code == 200) {
        ResponseDogsModel responseDogsModel = ResponseDogsModel.fromJson(response.data!);

        ref.read(responseDogsProvider.notifier).set(
          responseDogsModel.dogs.map((elem) => ResponseDogsDetailModel.fromJson(elem)).toList(),
        );

        // 조회 결과 
        result = true;
        
        // if(!context.mounted) return;
        // 로딩 끝
        // hideLoadingDialog(context);
      } else {
        if(!context.mounted) return result;
        // 로딩 끝
        // hideLoadingDialog(context);
        // 에러 알림창
        showAlertDialog(
          context: context, 
          middleText: "반려동물 조회에 실패했습니다.\n${response.response_message}"
        );
        return result;
      }
    } on DioException catch(e) {
      // debugPrint("========== Request Dogs Exception ==========");
      // debugPrint(e.toString());

      // 로딩 끝
      // if(!context.mounted) return;
      // hideLoadingDialog(context);

      // 에러 알림창
      if(!context.mounted) return result;
      showAlertDialog(
        context: context, 
        middleText: '반려동물 조회 요청에 실패했습니다.\n${Sentence.SERVER_ERR}',
      );
    }

    return result;
  }

  static Future<void> fnInitAppState(WidgetRef ref) async {
    final storage = ref.watch(secureStorageProvider);

    // await storage.delete(key: ProjectConstant.ACCESS_TOKEN);
    // await storage.delete(key: ProjectConstant.REFRESH_TOKEN);
    // await storage.delete(key: ProjectConstant.PET_ACTIVATED_INDEX);

    // 초기값으로 세팅
    // await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: null);
    // await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: null);
    // await storage.write(key: ProjectConstant.PET_ACTIVATED_INDEX, value: '0');
    
    // flutter_secure_storage 삭제
    await storage.deleteAll();
  }

  static Future<void> fnInvalidateAllState(WidgetRef ref) async {
    ref.invalidate(emailLoginEmailInputStatusCodeProvider);
    ref.invalidate(emailLoginPwdInputStatusCodeProvider);
    ref.invalidate(emailLoginButtonProvider);
    ref.invalidate(cameraImagePickerProvider);
    ref.invalidate(cameraUploadButtonProvider);
    ref.invalidate(cameraControllerProvider);
    ref.invalidate(cameraFlashProvider);
    ref.invalidate(responsePooMonthlyMeanProvider);
    ref.invalidate(responsePooDailyStatusProvider);
    ref.invalidate(homePoopReportBenchmarkScoreProvider);
    ref.invalidate(homeActivityReportPeriodSelectProvider);
    ref.invalidate(homeSleepReportPeriodSelectProvider);
    ref.invalidate(myPetAddTypeFilterProvider);
    ref.invalidate(myPetAddTypeDropdownProvider);
    ref.invalidate(myPetAddFeedFilterProvider);
    ref.invalidate(myPetAddFeedDropdownProvider);
    ref.invalidate(myPetAddSizeButtonProvider);
    ref.invalidate(myPetAddGenderButtonProvider);
    ref.invalidate(myPetAddNeuterButtonProvider);
    ref.invalidate(myPetAddFeedAmountButtonProvider);
    ref.invalidate(myPetAddNameInputStatusCodeProvider);
    ref.invalidate(myPetAddBirthInputStatusCodeProvider);
    ref.invalidate(myPetAddFeedTimeListProvider);
    ref.invalidate(myPetAddFeedTimeDeleteListProvider);
    ref.invalidate(myPetAddFeedTimeMeridiemButtonProvider);
    ref.invalidate(myPetAddFeedTimeSelectModeProvider);
    ref.invalidate(requestNewDogProvider); // 반려동물 추가하기 모델
    ref.invalidate(requestUpdateDogProvider); // 반려동물 수정하기 모델
    ref.invalidate(myPetAddButtonProvider); // 반려동물 추가하기 버튼
    ref.invalidate(requestNewDogProvider); // 반려동물 추가하기 모델
    ref.invalidate(requestUpdateDogProvider); // 반려동물 수정하기 모델
    ref.invalidate(myPetUpdateButtonProvider); // 반려동물 수정하기 버튼
    ref.invalidate(registerEmailInputStatusCodeProvider);
    ref.invalidate(registerPwdInputStatusCodeProvider);
    ref.invalidate(registerPwdConfirmInputStatusCodeProvider);
    ref.invalidate(requestEmailRegisterProvider);
    ref.invalidate(registerButtonProvider);
  }

  static Future<void> fnDeleteLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('bottomNav');
    await prefs.remove('responseUserMypage');
    await prefs.remove('responseDogs');
    await prefs.remove('homeActivatedPetNav');
    await prefs.remove('homePoopReportBenchmarkScore');
    await prefs.remove('homeSleepReportBenchmarkSleepEfficiency');
    await prefs.remove('myPetAddBirthInputStatusCode');
    await prefs.remove('myPetAddButton');
    await prefs.remove('myPetAddFeedAmountButton');
    await prefs.remove('myPetAddFeedDropdown');
    await prefs.remove('myPetAddFeedFilter');
    await prefs.remove('myPetAddFeedTimeDeleteList');
    await prefs.remove('myPetAddFeedTimeMeridiemButton');
    await prefs.remove('myPetAddFeedTimeSelectMode');
    await prefs.remove('myPetAddGenderButton');
    await prefs.remove('myPetAddNameInputStatusCode');
    await prefs.remove('myPetAddNeuterButton');
    await prefs.remove('myPetAddSizeButton');
    await prefs.remove('myPetAddTypeDropdown');
    await prefs.remove('myPetAddTypeFilter');
    await prefs.remove('myPetUpdateButton');
    await prefs.remove('myProfileBirthInputStatusCode');
    await prefs.remove('myProfileGenderButton');
    await prefs.remove('myProfileInterestButton');
    await prefs.remove('myProfilePhoneNumberInputStatusCode');
    await prefs.remove('myProfileUpdateButton');
    await prefs.remove('requestNewDog');
    await prefs.remove('requestUpdateDog');
    await prefs.remove('requestUsers');
    await prefs.remove('responseDogs');
    await prefs.remove('responsePooDailyStatus');
    await prefs.remove('responsePooMonthlyMean');
    await prefs.remove('responseUserMypage');
  }
}