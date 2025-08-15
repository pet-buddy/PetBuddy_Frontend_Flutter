import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:petbuddy_frontend_flutter/data/provider/response_poo_monthly_mean_provider.dart';
import 'package:petbuddy_frontend_flutter/screens/home/widget/home_poop_daily_report_dialog.dart';
import 'package:petbuddy_frontend_flutter/screens/home/widget/inverted_triangle_painter.dart';

class HomePoopReportScreen extends ConsumerStatefulWidget {
  const HomePoopReportScreen({super.key});

  @override
  ConsumerState<HomePoopReportScreen> createState() => HomePoopReportScreenState();
}

class HomePoopReportScreenState extends ConsumerState<HomePoopReportScreen> with HomeController, MyController, CustomCameraController {
  
  @override
  void initState() {
    super.initState();
    fnInitHomeController(ref, context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      
      final homeActivatedPetNav = ref.read(homeActivatedPetNavProvider.notifier).get();
      final responseDogs = ref.read(responseDogsProvider.notifier).get();
      // 벤치마크 반려동물 점수
      // ref.read(homePoopReportBenchmarkScoreProvider.notifier).set(
      //   (fnGetBenchmarkHealthyScore(
      //     responseDogs[homeActivatedPetNav].pet_size, 
      //     fnGetDaysDiff(responseDogs[homeActivatedPetNav].pet_birth)
      //   ) * 100).toInt(),
      // );

      // TODO : 홈 화면 대시보드 조회 API 생성 시 주석해제
      // 반려동물 한달평균 건강점수
      // fnPooMonthlyMeanExec(DateFormat("yyyy-MM").format(DateTime.now()), responseDogs[homeActivatedPetNav].pet_id);

      // 해당 월 세팅
      ref.read(homePoopReportMonthSelectProvider.notifier).set(int.parse(DateFormat("MM").format(DateTime.now()).toString()));
      ref.read(homePoopReportPreviousMonthSelectProvider.notifier).set(int.parse(DateFormat("MM").format(DateTime.now()).toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    List<DateTime?> selectedDay = [date];

    final homePoopReportMonthSelectState = ref.watch(homePoopReportMonthSelectProvider);
    // final homePoopReportPreviousMonthSelectState = ref.watch(homePoopReportPreviousMonthSelectProvider);
    final homeActivatedPetNavState = ref.watch(homeActivatedPetNavProvider);
    final responseDogsState = ref.watch(responseDogsProvider);
    final responsePooMonthlyMeanState = ref.watch(responsePooMonthlyMeanProvider);
    final homePoopReportBenchmarkScoreState = ref.watch(homePoopReportBenchmarkScoreProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 벤치마크 반려동물 점수
      ref.read(homePoopReportBenchmarkScoreProvider.notifier).set(
        (fnGetBenchmarkHealthyScore(
          responseDogsState[homeActivatedPetNavState].pet_size, 
          fnGetDaysDiff(responseDogsState[homeActivatedPetNavState].pet_birth)
        ) * 100).toInt(),
      );
    });

    final now = DateTime.now(); // 오늘 날짜
    final nowDate = now.toString().substring(0, 10);

    final config = CalendarDatePicker2WithActionButtonsConfig(
      lastDate: DateTime.now(),
      disableModePicker: true,
      modePickerBuilder: ({isMonthPicker, required monthDate, required viewMode}) {
        final prevMonth = ref.read(homePoopReportPreviousMonthSelectProvider.notifier).get();
        final currentMonth = monthDate.month;

        if (prevMonth != currentMonth) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(homePoopReportPreviousMonthSelectProvider.notifier).set(currentMonth);
            // 활성화된 월 저장
            ref.read(homePoopReportMonthSelectProvider.notifier).set(currentMonth);

            // print(prevMonth);
            // print(currentMonth);
            fnPooMonthlyMeanExec(monthDate.toString().substring(0, 7), responseDogsState[homeActivatedPetNavState].pet_id);
          });
        }

        var calendarTitle = Container(
          alignment: Alignment.center,
          width: 106,
          height: 29,
          decoration: BoxDecoration(
            color: CustomColor.yellow03,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: RichText(
              text: TextSpan(
              children: [
                TextSpan(
                  text: '${monthDate.year} ${monthDate.month.toString().padLeft(2, '0')}',
                  style: CustomText.body10.copyWith(
                    color: CustomColor.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ),
        );
        
        return Center(
          child: isMonthPicker == true 
            ? const Text('')
            : calendarTitle,
        );
      },
      monthBuilder: ({decoration, isCurrentMonth, isDisabled, isSelected, required month, textStyle}) {
        
      },
      modePickerTextHandler: ({required monthDate, isMonthPicker}) {
        return '';
      },
      lastMonthIcon: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: SvgPicture.asset(
          "assets/icons/navigation/calendar_arrow_back.svg"
        ),
      ),
      nextMonthIcon: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: SvgPicture.asset(
          date.month == DateTime.now().month ? 
            "assets/icons/navigation/calendar_arrow_next.svg" : 
            "assets/icons/navigation/calendar_arrow_next.svg",
        ),
      ),
      firstDayOfWeek: 0,
      weekdayLabelTextStyle: CustomText.body10.copyWith(
        color: CustomColor.black
      ),
      dayMaxWidth: 60,
      dayBuilder: ({required date, decoration, isDisabled, isSelected, isToday, textStyle}) {
        final monthlyPoopList = responsePooMonthlyMeanState.monthly_poop_list.map((e) => PoopStatusModel.fromJson(e as Map<String, dynamic>)).toList();
        final grade = monthlyPoopList.firstWhere((elem) => elem.date == date.toString().substring(0, 10), orElse: () => PoopStatusModel(date: '', grade: '')).grade;

        return Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: nowDate == date.toString().substring(0, 10) ?
              CustomColor.yellow04 :
              CustomColor.white,
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                  child: Text(
                    date.day.toString(),
                    style: nowDate == date.toString().substring(0, 10) ? 
                      CustomText.body10.copyWith(
                        color: CustomColor.black,
                        fontWeight: FontWeight.bold,
                      ) :
                      CustomText.body10.copyWith(
                        color: CustomColor.black,
                      ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true, // 전체 높이 지원
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return HomePoopDailyReportDialog(date: date.toString().substring(0, 10),);
                      },
                    );
                  },
                  child: Container(
                    height: 42,
                    alignment: Alignment.bottomCenter,
                    child: grade.isNotEmpty ? 
                      Image.asset(
                        "assets/icons/etc/poop_status_$grade.png",
                        width: 35,
                        height: 35,
                      ) : 
                      const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      selectedDayTextStyle: const TextStyle(
        color: CustomColor.white, 
        fontWeight: FontWeight.w700
      ),
      selectedDayHighlightColor: CustomColor.yellow04,
      centerAlignModePicker: true,
      cancelButton: const SizedBox(
        height: 0,
      ),
      okButton: const SizedBox(
        height: 0,
      ),
    );
    
    return DefaultLayout(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: DefaultAppBar(
        title: '똥 분석 보고서',
        leadingOnPressed: () {
          if(!context.mounted) return;
          fnInvalidateHomePoopReportState();
          context.pop();
        },
        actionDisable: true,
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          fnInvalidateHomePoopReportState();
          context.pop();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16,),
                  // 달력 영역
                  Container(
                    width: fnGetDeviceWidth(context),
                    decoration: BoxDecoration(
                      color: CustomColor.white,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.gray04..withValues(alpha: 0.0),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ]
                    ),
                    child: CalendarDatePicker2WithActionButtons(
                      value: selectedDay,
                      config: config,
                      onDisplayedMonthChanged: (value) async {
                      },
                    ),
                  ),
                  const SizedBox(height: 32,),
                  // 월별 건강
                  Text(
                    '$homePoopReportMonthSelectState월 똥 건강 종합보고서',
                    style: CustomText.body7.copyWith(
                      color: const Color(0xFF0092CA),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  responsePooMonthlyMeanState.monthly_poop_list.isNotEmpty ?
                    Container(
                      height: 500,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: const BoxDecoration(
                        color: CustomColor.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(height: 8,),
                          SizedBox(
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${responsePooMonthlyMeanState.poop_score_total}',
                                  style: CustomText.heading1.copyWith(
                                    fontSize: 48.0,
                                    color: const Color(0xFF0092CA),
                                  ),
                                ),
                                const SizedBox(width: 4,),
                                Text(
                                  '점',
                                  style: CustomText.body9.copyWith(
                                    color: CustomColor.deepBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Container(
                                height: 48,
                                margin: const EdgeInsets.only(top: 12),
                                child: Text(
                                  '종합',
                                  style: CustomText.body9.copyWith(
                                    color: CustomColor.deepBlue,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: fnGetDeviceWidth(context) - 128,
                                height: 48,
                                child: Stack(
                                  children: [
                                    // 상태 가로 막대그래프
                                    Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      child: LayoutBuilder(builder: (context, contraints) {
                                        return Row(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: contraints.maxWidth / 3,
                                                  height: 10,
                                                  decoration: const BoxDecoration(
                                                    color:  Color(0xFFF62548),
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10),),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 4),
                                                  width: contraints.maxWidth / 3,
                                                  child: Text(
                                                    '나쁨',
                                                    style: CustomText.caption3.copyWith(
                                                      color: CustomColor.deepBlue,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  width: contraints.maxWidth / 3,
                                                  height: 10,
                                                  decoration: const BoxDecoration(
                                                    color:  Color(0xFFF6D72E),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 4),
                                                  width: contraints.maxWidth / 3,
                                                  child: Text(
                                                    '보통',
                                                    style: CustomText.caption3.copyWith(
                                                      color: CustomColor.deepBlue,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  width: contraints.maxWidth / 3,
                                                  height: 10,
                                                  decoration: const BoxDecoration(
                                                    color:  Color(0xFF63C728),
                                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10),),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 4),
                                                  width: contraints.maxWidth / 3,
                                                  child: Text(
                                                    '건강',
                                                    style: CustomText.caption3.copyWith(
                                                      color: CustomColor.deepBlue,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                    // 점수를 가리킬 아래 화살표
                                    Positioned(
                                      top: 0,
                                      // 1.5보다 적을 때 1.5로 세팅, 98.5보다 클 때 98.5로 세팅
                                      left: (fnGetDeviceWidth(context) - 128) * ((responsePooMonthlyMeanState.poop_score_total! < 1.5 ? 1.5 : responsePooMonthlyMeanState.poop_score_total! > 98.5 ? 98.5 : responsePooMonthlyMeanState.poop_score_total!)/100) - 5,
                                      child: CustomPaint(
                                        size: const Size(10, 10), // 캔버스 크기
                                        painter: InvertedTrianglePainter(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8,),
                          // 변 건강 상태 색깔로 출력
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '색상',
                                    style: CustomText.caption3.copyWith(
                                      color: CustomColor.deepBlue,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  SvgPicture.asset(
                                    'assets/icons/etc/status_${fnGetPoopStatus(responsePooMonthlyMeanState.poop_score_color!)}.svg',
                                    width: 35,
                                    height: 35,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '수분',
                                    style: CustomText.caption3.copyWith(
                                      color: CustomColor.deepBlue,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  SvgPicture.asset(
                                    'assets/icons/etc/status_${fnGetPoopStatus(responsePooMonthlyMeanState.poop_score_moisture!)}.svg',
                                    width: 35,
                                    height: 35,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '기생충 여부',
                                    style: CustomText.caption3.copyWith(
                                      color: CustomColor.deepBlue,
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  SvgPicture.asset(
                                    'assets/icons/etc/status_${fnGetPoopStatus(responsePooMonthlyMeanState.poop_score_parasite!)}.svg',
                                    width: 35,
                                    height: 35,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 32,),
                          // Summary
                          Text(
                            '$homePoopReportMonthSelectState월 똥 상태 Summary',
                            style: CustomText.body8.copyWith(
                              color:const Color(0xFF0092CA),
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 8,),
                          Text(
                            '현재 건강점수는 ${responsePooMonthlyMeanState.poop_score_total}점이에요!',
                            style: CustomText.body9.copyWith(
                              color:CustomColor.deepBlue,
                            ),
                          ),
                          Text(
                            fnGetPoopStatus(responsePooMonthlyMeanState.poop_score_total!) == 'bad' ? 
                              '관리가 시급해요 :(' :
                                fnGetPoopStatus(responsePooMonthlyMeanState.poop_score_total!) == 'caution' ? 
                                  '조금 더 주의를 기울여주세요 :|' : 
                                  '이대로 관리해주세요! :)',
                            style: CustomText.body9.copyWith(
                              color:CustomColor.deepBlue,
                            ),
                          ),
                          const SizedBox(height: 16,),
                          Text(
                            responseDogsState[homeActivatedPetNavState].pet_name,
                            style: CustomText.body11.copyWith(
                              color:const Color(0xFF0092CA),
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Container(
                            width: fnGetDeviceWidth(context) * (responsePooMonthlyMeanState.poop_score_total!/100),
                            height: 23,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: const BoxDecoration(
                              color: CustomColor.blue03,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20), 
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '건강점수 ${responsePooMonthlyMeanState.poop_score_total}점',
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomText.caption3.copyWith(
                                    color: CustomColor.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16,),
                          Text(
                            '${responseDogsState[homeActivatedPetNavState].pet_size == smallSize ? 
                                '소형견' : 
                                  responseDogsState[homeActivatedPetNavState].pet_size == mediumSize ?
                                    '중형견' :
                                      '대형견'} 평균 건강점수',
                            style: CustomText.body11.copyWith(
                              color: CustomColor.yellow02,
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Container(
                            width: fnGetDeviceWidth(context) * (homePoopReportBenchmarkScoreState/100),
                            height: 23,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: const BoxDecoration(
                              color: CustomColor.yellow03,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20), 
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '건강점수 $homePoopReportBenchmarkScoreState',
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomText.caption3.copyWith(
                                    color: CustomColor.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // TODO : 월별 점수 정보 받아오기
                          // AspectRatio(
                          //   aspectRatio: 1.8,
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          //     child: BarChart(
                          //       BarChartData(
                          //         alignment: BarChartAlignment.spaceAround,
                          //         maxY: 110,
                          //         minY: -5,
                          //         barTouchData: BarTouchData(enabled: false),
                          //         titlesData: FlTitlesData(
                          //           leftTitles: const AxisTitles(
                          //             sideTitles: SideTitles(showTitles: false),
                          //           ),
                          //           topTitles: const AxisTitles(
                          //             sideTitles: SideTitles(showTitles: false),
                          //           ),
                          //           bottomTitles: AxisTitles(
                          //             sideTitles: SideTitles(
                          //               showTitles: true,
                          //               reservedSize: 16,
                          //               getTitlesWidget: (value, meta) {
                                          
                          //                 const style = TextStyle(
                          //                   color: Color(0xFF0092CA),
                          //                   fontWeight: FontWeight.w400,
                          //                   fontSize: 8,
                          //                 );

                          //                 switch (value.toInt()) {
                          //                   default:
                          //                     return Text('${value.toInt()+1}월', style: style);
                          //                 }
                          //               },
                          //             ),
                          //           ),
                          //           rightTitles: AxisTitles(
                          //             sideTitles: SideTitles(
                          //               showTitles: true,
                          //               reservedSize: 16,
                          //               interval: 10,
                          //               getTitlesWidget: (value, meta) {
                          //                 return Text(
                          //                   value.toInt() % 50 == 0 ? value.toInt().toString() : '',
                          //                   style: const TextStyle(
                          //                     color: Color(0xFF0092CA),
                          //                     fontWeight: FontWeight.w400,
                          //                     fontSize: 8,
                          //                   ),
                          //                   textAlign: TextAlign.right,
                          //                 );
                          //               },
                          //             ),
                          //           ),
                          //         ),
                          //         gridData: FlGridData(
                          //           show: true,
                          //           drawVerticalLine: false,
                          //           horizontalInterval: 10,
                          //           getDrawingHorizontalLine: (value) => FlLine(
                          //             color: const Color(0xFFB7B5AF).withValues(alpha: 0.4),
                          //             strokeWidth: 1,
                          //           ),
                          //         ),
                          //         borderData: FlBorderData(
                          //           show: false
                          //         ),
                          //         // TODO : 월별 똥 분석 점수 가져오기
                          //         barGroups: List.generate(values.length, (index) {
                          //           return BarChartGroupData(
                          //             x: index,
                          //             barRods: [
                          //               BarChartRodData(
                          //                 toY: values[index].toDouble(),
                          //                 width: 8,
                          //                 color: Colors.lightBlue,
                          //                 borderRadius: BorderRadius.circular(8),
                          //               ),
                          //             ],
                          //           );
                          //         }),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ) : 
                    Container(
                      height: 500,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: const BoxDecoration(
                        color: CustomColor.white,
                      ),
                      child: Center(
                        child: homePoopReportMonthSelectState == int.parse(DateFormat("MM").format(DateTime.now()).toString()) ?
                          DefaultIconButton(
                            disabled: false,
                            onPressed: () {
                              // fnCallCameraScreen(context, mode: "method_call");
                              ref.read(bottomNavProvider.notifier).set(1);
                              context.goNamed('camera_upload_screen');
                            }, 
                            text: '사진 촬영하기',
                            height: 42,
                            borderRadius: 16,
                            backgroundColor: CustomColor.yellow03,
                            borderColor: CustomColor.yellow03,
                            textColor: const Color.fromARGB(255, 28, 22, 22),
                            elevation: 4,
                            svgPicture: SvgPicture.asset(
                              'assets/icons/etc/camera_icon_border_black.svg',
                              width: 24,
                              height: 24,
                            ),
                          ) : 
                          DefaultIconButton(
                            disabled: true,
                            onPressed: () {}, 
                            text: '$homePoopReportMonthSelectState월 분석 데이터가 없습니다.',
                            height: 42,
                            borderRadius: 16,
                            elevation: 0,
                            disalbedBackgroundColor: CustomColor.white,
                            disalbedBorderColor: CustomColor.gray03,
                            disalbedTextColor: CustomColor.black,
                          )
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}