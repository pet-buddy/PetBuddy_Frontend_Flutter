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

    await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: null);
    await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: null);
    await storage.write(key: ProjectConstant.PET_ACTIVATED_INDEX, value: '0');
  }
}