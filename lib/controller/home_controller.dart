import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/sentence.dart';
import 'package:petbuddy_frontend_flutter/common/widget/dialog/alert_dialog.dart';
import 'package:petbuddy_frontend_flutter/common/widget/dialog/loading_dialog.dart';
import 'package:petbuddy_frontend_flutter/data/model/response_poo_daily_status_model.dart';
import 'package:petbuddy_frontend_flutter/data/model/response_poo_monthly_mean_model.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
import 'package:petbuddy_frontend_flutter/data/provider/response_poo_daily_status_provider.dart';
import 'package:petbuddy_frontend_flutter/data/provider/response_poo_monthly_mean_provider.dart';
import 'package:petbuddy_frontend_flutter/data/repository/poo_repository.dart';

mixin class HomeController {
  late final WidgetRef homeRef;
  late final BuildContext homeContext;
  // ref, context 초기화
  void fnInitHomeController(WidgetRef ref, BuildContext context) {
    homeRef = ref;
    homeContext = context;
  }

  final Map<String, String> periodCode = {
    'Day': 'D',
    'Week': 'W',
    'Month': 'M',
    '6Month': '6M',
    'Year': 'Y'
  };

  PageController homeScreenPetController = PageController(initialPage: 0);

  void fnInvalidateHomePoopReportState() {
    homeRef.invalidate(homePoopReportMonthSelectProvider);
    // homeRef.invalidate(responsePooMonthlyMeanProvider);
    homeRef.invalidate(responsePooDailyStatusProvider);
  }

  void fnInvalidateHomeActivityReportState() {
    homeRef.invalidate(homeActivityReportPeriodSelectProvider);
  }

  // 점수별 상태 반환
  String fnGetPoopStatus(int score) {
    String poopStatus = '';

    if(score < 50) {
      poopStatus = 'bad';
    } else if(score >= 50 && score < 70) {
      poopStatus = 'caution';
    } else {
      poopStatus = 'good';
    }

    return poopStatus;
  }

  // 오늘 날짜와 생년월일 일수차이 
  int fnGetDaysDiff(String birth) {
    String convertedBirth = birth.replaceAll('-', '');

    DateTime today = DateTime.now();

    return int.parse(today.difference(DateTime.parse(convertedBirth)).inDays.toString());
  }

  double fnGetBenchmarkHealthyScore(String size, int days) {
    double benchmark = 0.0;

    if(size == 'SMALL' && days < 180) { 
      benchmark = 0.78;
    } else if(size == 'SMALL' && days >= 180 || days < 365) {
      benchmark = 0.8;      
    } else if(size == 'SMALL' && days >= 365 || days < 365*7) {
      benchmark = 0.8;      
    } else if(size == 'SMALL' && days >= 365*7) {
      benchmark = 0.78;      
    } else if(size == 'MEDIUM' && days < 180) {
      benchmark = 0.8;
    } else if(size == 'MEDIUM' && days >= 180 || days < 365) {
      benchmark = 0.8;      
    } else if(size == 'MEDIUM' && days >= 365 || days < 365*7) {
      benchmark = 0.8;      
    } else if(size == 'MEDIUM' && days >= 365*7) {
      benchmark = 0.78;      
    } else if(size == 'LARGE' && days < 180) {
      benchmark = 0.8;
    } else if(size == 'LARGE' && days >= 180 || days < 365) {
      benchmark = 0.8;      
    } else if(size == 'LARGE' && days >= 365 || days < 365*7) {
      benchmark = 0.8;      
    } else if(size == 'LARGE' && days >= 365*7) {
      benchmark = 0.75;      
    }

    return benchmark;
  }

  Future<void> fnPooDailyStatusExec(String date, int dog_id) async {
    try {
      // 로딩 시작
      showLoadingDialog(context: homeContext);

      final response = await homeRef.read(pooRepositoryProvider).requestPooDailyStatusRepository(date, dog_id);

      if(response.response_code == 200) {
        ResponsePooDailyStatusModel responsePooDailyStatusModel = ResponsePooDailyStatusModel.fromJson(response.data![0]);

        homeRef.read(responsePooDailyStatusProvider.notifier).set(responsePooDailyStatusModel);
      
        if(!homeContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(homeContext);
      } else {
        if(!homeContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(homeContext);
        // 에러 알림창
        showAlertDialog(
          context: homeContext, 
          middleText: "해당 날짜의 반려동물 변 데이터를 불러오지 못했습니다.",
        );
        return;
      }
    } on DioException catch(e) {
      // 로딩 끝
      if(!homeContext.mounted) return;
      hideLoadingDialog(homeContext);

      // 에러 알림창
      if(!homeContext.mounted) return;
      showAlertDialog(
        context: homeContext, 
        middleText: '${Sentence.SERVER_ERR}\n$e',
      );
    }
  }

  Future<void> fnPooMonthlyMeanExec(String month, int dog_id) async {
    try {
      // 로딩 시작
      showLoadingDialog(context: homeContext);

      final response = await homeRef.read(pooRepositoryProvider).requestPooMonthlyMeanRepository(month, dog_id);

      if(response.response_code == 200) {
        ResponsePooMonthlyMeanModel responsePooMonthlyMeanModel = ResponsePooMonthlyMeanModel.fromJson(response.data!);

        homeRef.read(responsePooMonthlyMeanProvider.notifier).set(responsePooMonthlyMeanModel);
      
        if(!homeContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(homeContext);
      } else {
        if(!homeContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(homeContext);
        // 에러 알림창
        showAlertDialog(
          context: homeContext, 
          middleText: "해당 월의 반려동물 변 데이터를 불러오지 못했습니다.\n${response.response_message}",
        );
        return;
      }
    } on DioException catch(e) {
      // 로딩 끝
      if(!homeContext.mounted) return;
      hideLoadingDialog(homeContext);

      // 에러 알림창
      if(!homeContext.mounted) return;
      showAlertDialog(
        context: homeContext, 
        middleText: '${Sentence.SERVER_ERR}\n$e',
      );
    }
  }
}
