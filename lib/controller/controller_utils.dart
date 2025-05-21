import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/response_user_mypage_model.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
import 'package:petbuddy_frontend_flutter/data/repository/user_repository.dart';

class ControllerUtils {
  
  static Future<void> fnGetUserMypage(WidgetRef ref) async {
    final response = await ref.read(userRepositoryProvider).requestUserMypageRepository();

    debugPrint("========== Get User Mypage Response =========");
    debugPrint(response.toString());

    if(response.response_code == 200) {
      ResponseUserMypageModel responseUserMypageModel = ResponseUserMypageModel.fromJson(response.data);
      // 사용자 정보 세팅
      ref.refresh(responseUserMypageProvider.notifier).set(responseUserMypageModel);
    } 
  }


  // TODO : 반려동물 정보 세팅

  // TODO : 홈 화면 정보 세팅
  
}