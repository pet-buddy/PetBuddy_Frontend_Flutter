import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:petbuddy_frontend_flutter/common/const/sentence.dart';
import 'package:petbuddy_frontend_flutter/common/widget/dialog/alert_dialog.dart';
import 'package:petbuddy_frontend_flutter/common/widget/dialog/loading_dialog.dart';
import 'package:petbuddy_frontend_flutter/data/model/model.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
import 'package:petbuddy_frontend_flutter/data/repository/activity_repository.dart';
import 'package:petbuddy_frontend_flutter/data/repository/poo_repository.dart';

mixin class HomeController {
  late final WidgetRef homeRef;
  late final BuildContext homeContext;
  // ref, context 초기화
  void fnInitHomeController(WidgetRef ref, BuildContext context) {
    homeRef = ref;
    homeContext = context;
  }

  final List<HomeSleepRecommandedAdviceModel> sleepRecommandedAdvice = [
    // 75% 미만
    HomeSleepRecommandedAdviceModel(
      title: '수면 환경 개선',
      text: '수면 공간을 어둡고 조용하게 만들어주세요',
      svgPicture: SvgPicture.asset(
        'assets/icons/etc/sleep_moon.svg',
        width: 24,
        height: 24,
      ),
    ),
    HomeSleepRecommandedAdviceModel(
      title: '안정된 루틴',
      text: '매일 같은 시간에 산책 및 식사로 생활 리듬을 고정해주세요',
      svgPicture: SvgPicture.asset(
        'assets/icons/etc/sleep_clock.svg',
        width: 24,
        height: 24,
      ),
    ),
    HomeSleepRecommandedAdviceModel(
      title: '음식/간식 변경',
      text: '음식/간식이 맞지 않아 일어나는 현상일 수 있습니다',
      svgPicture: SvgPicture.asset(
        'assets/icons/etc/sleep_tableware.svg',
        width: 24,
        height: 24,
      ),
    ),
    // 75%이상 ~ 85%미만
    HomeSleepRecommandedAdviceModel(
      title: '낮잠 조정',
      text: '낮잠이 지나치게 길면 밤잠에 영향을 줄 수 있으므로\n낮잠 시간은 2~3시간으로 제한하세요',
      svgPicture: SvgPicture.asset(
        'assets/icons/etc/sleep_moon.svg',
        width: 24,
        height: 24,
      ),
    ),
    HomeSleepRecommandedAdviceModel(
      title: '일정 유지',
      text: '저녁 산책 시간을 일정하게 고정해주세요\n(너무 늦은 산책은 자제)',
      svgPicture: SvgPicture.asset(
        'assets/icons/etc/sleep_clock.svg',
        width: 24,
        height: 24,
      ),
    ),
    HomeSleepRecommandedAdviceModel(
      title: '저녁 자극 줄이기',
      text: '취침 1시간 전에는 강렬한 놀이 대신\n가벼운 마사지나 천천히 걷는 산책이 좋아요',
      svgPicture: SvgPicture.asset(
        'assets/icons/etc/sleep_plump_ball.svg',
        width: 24,
        height: 24,
      ),
    ),
    HomeSleepRecommandedAdviceModel(
      title: '밤에 깨는 원인 파악',
      text: '외부 소음, 급변하는 환경 또는 배뇨 습관을 점검해 보세요',
      svgPicture: SvgPicture.asset(
        'assets/icons/etc/sleep_warning.svg',
        width: 24,
        height: 24,
      ),
    ),
    // 85%이상
    HomeSleepRecommandedAdviceModel(
      title: '긍정 강화',
      text: '특정 시간대에 조용히 휴식을 취할 경우\n간식이나 칭찬으로 강화해 주세요',
      svgPicture: SvgPicture.asset(
        'assets/icons/etc/sleep_heart.svg',
        width: 24,
        height: 24,
      ),
    ),
    HomeSleepRecommandedAdviceModel(
      title: '수면 시간 고정',
      text: '수면 시간을 특정 시간대로 설정하여 일관된 리듬을 만들어 주세요',
      svgPicture: SvgPicture.asset(
        'assets/icons/etc/sleep_clock.svg',
        width: 24,
        height: 24,
      ),
    ),
    HomeSleepRecommandedAdviceModel(
      title: '패턴 유지',
      text: '현재 습관도 안정적인 상태에요! 지속적으로 관리해주세요 :)',
      svgPicture: SvgPicture.asset(
        'assets/icons/etc/sleep_thumb.svg',
        width: 24,
        height: 24,
      ),
    ),
    HomeSleepRecommandedAdviceModel(
      title: '밤에 깨는 원인 파악',
      text: '외부 소음, 급변하는 환경 또는 배뇨 습관을 점검해 보세요',
      svgPicture: SvgPicture.asset(
        'assets/icons/etc/sleep_warning.svg',
        width: 24,
        height: 24,
      ),
    ),
  ];

  // 미사용
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
  PageController homeSleepReportScreenPeriodController = PageController(initialPage: 0);

  void fnInvalidateHomePoopReportState() {
    // homeRef.invalidate(homePoopReportMonthSelectProvider);
    // 현재 월 저장
    homeRef.read(homePoopReportMonthSelectProvider.notifier).set(int.parse(DateFormat("MM").format(DateTime.now()).toString()));
    // homeRef.invalidate(responsePooMonthlyMeanProvider);
    homeRef.invalidate(responsePooDailyStatusProvider);
    homeRef.invalidate(homePoopReportBenchmarkScoreProvider);
  }

  void fnInvalidateHomeActivityReportState() {
    homeRef.invalidate(homeActivityReportPeriodSelectProvider);
    homeRef.invalidate(homeActivityReportUserPawsProvider);
    homeRef.invalidate(homeActivityReportPawsProvider);
    homeRef.invalidate(homeActivityReportBenchmarkPawsProvider);
  }

  void fnInvalidateHomeSleepReportState() {
    homeRef.invalidate(homeSleepReportPeriodSelectProvider);
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

  Future<void> fnGetUserPawsExec() async {
    try {
      // 로딩 시작
      showLoadingDialog(context: homeContext);

      final response = await homeRef.read(activityRepositoryProvider).requestGetUserStepsRepository();

      if(response.response_code == 200) {
        if(!homeContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(homeContext);
        // 사용자 걸음수를 사용자 Paws 점수에 저장
        final userPaws = (response.data ?? 0).toDouble();
        homeRef.read(homeActivityReportUserPawsProvider.notifier).set(userPaws);
      } else {
        if(!homeContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(homeContext);
        // 에러 알림창
        showAlertDialog(
          context: homeContext, 
          middleText: "사용자 걸음수를 불러오지 못했습니다.\n${response.response_message}",
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

  Future<void> fnSetUserPawsExec(int userStep) async {
    try {
      // 로딩 시작
      showLoadingDialog(context: homeContext);

      final response = await homeRef.read(activityRepositoryProvider).requestPatchUserStepsRepository(RequestUserStepModel(step: userStep));

      if(response.response_code == 200) {
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
          middleText: "사용자 걸음수를 저장하지 못했습니다.\n${response.response_message}",
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

  double fnGetBenchmarkPaws(String size, int days) {
    double benchmark = 0.0;

    if(size == 'SMALL' && days < 180) { 
      benchmark = 6494;
    } else if(size == 'SMALL' && days >= 180 || days < 365) {
      benchmark = 5714;      
    } else if(size == 'SMALL' && days >= 365 || days < 365*7) {
      benchmark = 6015;      
    } else if(size == 'SMALL' && days >= 365*7) {
      benchmark = 6723;      
    } else if(size == 'MEDIUM' && days < 180) {
      benchmark = 5051;
    } else if(size == 'MEDIUM' && days >= 180 || days < 365) {
      benchmark = 4444;      
    } else if(size == 'MEDIUM' && days >= 365 || days < 365*7) {
      benchmark = 4678;      
    } else if(size == 'MEDIUM' && days >= 365*7) {
      benchmark = 5229;      
    } else if(size == 'LARGE' && days < 180) {
      benchmark = 4132;
    } else if(size == 'LARGE' && days >= 180 || days < 365) {
      benchmark = 3636;      
    } else if(size == 'LARGE' && days >= 365 || days < 365*7) {
      benchmark = 3828;      
    } else if(size == 'LARGE' && days >= 365*7) {
      benchmark = 4278;      
    }

    return benchmark;
  }

  HomeSleepBenchmarkSleepEfficiencyModel fnGetBenchmarkSleepEfficiency(String size, int days) {
    const yearDays = 365;
    HomeSleepBenchmarkSleepEfficiencyModel benchmarkSleepEfficiencyModel = HomeSleepBenchmarkSleepEfficiencyModel(hour: 0, percent: 0);

    if(size == 'SMALL' && days < yearDays) { // 소형, 유년기 (1년 미만) 
      benchmarkSleepEfficiencyModel = HomeSleepBenchmarkSleepEfficiencyModel(hour: 19, percent: 94);
    } else if(size == 'SMALL' && days >= yearDays || days < yearDays*8) { // 소형, 청년기 (1~7세) 
      benchmarkSleepEfficiencyModel = HomeSleepBenchmarkSleepEfficiencyModel(hour: 13.5, percent: 92);
    } else if(size == 'SMALL' && days >= yearDays*8 || days < yearDays*12) { // 소형, 성년기 (8~12세) 
      benchmarkSleepEfficiencyModel = HomeSleepBenchmarkSleepEfficiencyModel(hour: 13, percent: 90);
    } else if(size == 'SMALL' && days >= yearDays*12) { // 소형, 노년기 (12세 이상) 
      benchmarkSleepEfficiencyModel = HomeSleepBenchmarkSleepEfficiencyModel(hour: 16, percent: 88);
    } else if(size == 'MEDIUM' && days < yearDays) { // 중형, 유년기 (1년 미만) 
      benchmarkSleepEfficiencyModel = HomeSleepBenchmarkSleepEfficiencyModel(hour: 19, percent: 93);
    } else if(size == 'MEDIUM' && days >= yearDays || days < yearDays*8) { // 중형, 청년기 (1~7세)
      benchmarkSleepEfficiencyModel = HomeSleepBenchmarkSleepEfficiencyModel(hour: 13, percent: 91);
    } else if(size == 'MEDIUM' && days >= yearDays*8 || days < yearDays*12) { // 중형, 성년기 (8~12세) 
      benchmarkSleepEfficiencyModel = HomeSleepBenchmarkSleepEfficiencyModel(hour: 13, percent: 88);
    } else if(size == 'MEDIUM' && days >= yearDays*12) { // 중형, 노년기 (12세 이상) 
      benchmarkSleepEfficiencyModel = HomeSleepBenchmarkSleepEfficiencyModel(hour: 16, percent: 86);
    } else if(size == 'LARGE' && days < yearDays) { // 대형, 유년기 (1년 미만) 
      benchmarkSleepEfficiencyModel = HomeSleepBenchmarkSleepEfficiencyModel(hour: 20, percent: 91);
    } else if(size == 'LARGE' && days >= yearDays || days < yearDays*8) { // 대형, 청년기 (1~7세) 
      benchmarkSleepEfficiencyModel = HomeSleepBenchmarkSleepEfficiencyModel(hour: 13, percent: 89);
    } else if(size == 'LARGE' && days >= yearDays*8 || days < yearDays*12) { // 대형, 성년기 (8~12세) 
      benchmarkSleepEfficiencyModel = HomeSleepBenchmarkSleepEfficiencyModel(hour: 13, percent: 87);
    } else if(size == 'LARGE' && days >= yearDays*12) { // 대형, 노년기 (12세 이상) 
      benchmarkSleepEfficiencyModel = HomeSleepBenchmarkSleepEfficiencyModel(hour: 17, percent: 83);
    }

    return benchmarkSleepEfficiencyModel;
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
