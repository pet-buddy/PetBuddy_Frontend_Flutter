import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
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

  // ########## 활동량 분석 - 임시 데이터 시작 ##########
  final highlightValues = [1000.0, 0.0, 1250.0, 300.0, 2000.0, 400.0, 500.0, 800.0, 
                    1000.0, 0.0, 5250.0, 300.0, 2000.0, 400.0, 1500.0, 1800.0,
                    1000.0, 0.0, 1250.0, 3600.0, 5000.0, 400.0, 5200.0, 8100.0];

  

  // 시간별 반려견 활동 데이터 (각 시간대별 Paw 점수)
  List<FlSpot> petHourlyPaws = [
    const FlSpot(0, 0),    // 0시: 0걸음
    const FlSpot(3, 1000), // 3시: 1000걸음
    const FlSpot(6, 1500), // 6시: 1500걸음
    const FlSpot(9, 800),  // 9시: 800걸음
    const FlSpot(12, 500), // 오후 12시: 500걸음
    const FlSpot(15, 1000), // 오후 3시: 1000걸음
    const FlSpot(18, 1500), // 오후 6시: 1500걸음
    const FlSpot(21, 300),  // 오후 9시: 300걸음
    const FlSpot(24, 0),    // 새벽 12시: 0걸음
  ];
  
  // 시간별 평균 활동 데이터 (각 시간대별 Paw 점수)
  List<FlSpot> averageHourlyPaws = [
    const FlSpot(0, 0),    // 0시: 0걸음
    const FlSpot(3, 1200), // 3시: 1200걸음
    const FlSpot(6, 1800), // 6시: 1800걸음
    const FlSpot(9, 1000), // 9시: 1000걸음
    const FlSpot(12, 800), // 오후 12시: 800걸음
    const FlSpot(15, 1300), // 오후 3시: 1300걸음
    const FlSpot(18, 1700), // 오후 6시: 1700걸음
    const FlSpot(21, 500),  // 오후 9시: 500걸음
    const FlSpot(24, 0),    // 새벽 12시: 0걸음
  ];
  // ########## 활동량 분석 - 임시 데이터 끝 ##########

  PageController homeScreenPetController = PageController(initialPage: 0);

  void fnInvalidateHomePoopReportState() {
    homeRef.invalidate(homePoopReportMonthSelectProvider);
    // homeRef.invalidate(responsePooMonthlyMeanProvider);
    homeRef.invalidate(responsePooDailyStatusProvider);
    homeRef.invalidate(homePoopReportBenchmarkScoreProvider);
  }

  void fnInvalidateHomeActivityReportState() {
    homeRef.invalidate(homeActivityReportPeriodSelectProvider);
  }

  // ########## 반려동물 활동량 분석 ##########
  List<FlSpot> fnGetCumulativePaws(List<FlSpot> hourlyActivityPaws) {
    List<FlSpot> cumulativeData = [];
    double cumulativePaws = 0;
    
    for (FlSpot flSpot in hourlyActivityPaws) {
      cumulativePaws += flSpot.y;
      cumulativeData.add(FlSpot(flSpot.x, cumulativePaws));
    }
    
    return cumulativeData;
  }

  // ########## 반려동물 똥 분석 ##########

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
        // ResponsePooDailyStatusModel responsePooDailyStatusModel = ResponsePooDailyStatusModel.fromJson(response.data![0]);
        List<ResponsePooDailyStatusModel> responsePooDailyStatusModelList = (response.data as List<dynamic>).map((elem) => ResponsePooDailyStatusModel.fromJson(elem)).toList();
        // 맨 마지막 항목을 Provider에 넣기 - 하루에 여러 개의 변 사진을 업로드할 수 있기 때문
        homeRef.read(responsePooDailyStatusProvider.notifier).set(responsePooDailyStatusModelList[responsePooDailyStatusModelList.length-1]);
      
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
