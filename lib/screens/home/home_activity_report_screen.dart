import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
import 'package:petbuddy_frontend_flutter/screens/home/widget/widget.dart';

class HomeActivityReportScreen extends ConsumerStatefulWidget {
  const HomeActivityReportScreen({super.key});

  @override
  ConsumerState<HomeActivityReportScreen> createState() => HomeActivityReportScreenState();
}

class HomeActivityReportScreenState extends ConsumerState<HomeActivityReportScreen> with HomeController, MyController {

  @override
  void initState() {
    super.initState();
    fnInitHomeController(ref, context);
  }

  // 임시 변수
  DateTime selectedDate = DateTime.now();
  // 사용자(보호자) 걸음 수 가져오기 위한 패키지
  final health = Health();

  Future<void> fnGetUserStepData() async {
    // 웹 브라우저일 경우 실행X
    if(kIsWeb) return;

    // 가져올 데이터 유형 정의
    final types = [HealthDataType.STEPS];
    
    // 권한 요청
    final requested = await health.requestAuthorization(types,);

    if (requested) {
      try {
        final now = DateTime.now();
        final midnight = DateTime(now.year, now.month, now.day);
        
        int? steps = await health.getTotalStepsInInterval(midnight, now);

        // TODO : 사용자 걸음 수 저장

      } catch (e) {
        debugPrint("걸음 수를 가져오던 중 오류가 발생했습니다.\n$e");

        if(!context.mounted) return;
        showAlertDialog(
          context: context, 
          middleText: "걸음 수를 가져오던 중 오류가 발생했습니다.",
          buttonText: "확인",
        );
      }
    } else {
      if(!context.mounted) return;
      showAlertDialog(
        context: context, 
        middleText: "접근 권한이 거부되어 걸음 수를 가져올 수 없습니다.\n설정에서 권한을 허용해주세요.",
        onConfirm: () {
          openAppSettings();
        },
        buttonText: "확인",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final homeActivityReportPeriodSelectState = ref.watch(homeActivityReportPeriodSelectProvider);
    final homeActivatedPetNavState = ref.watch(homeActivatedPetNavProvider);
    final responseDogsState = ref.watch(responseDogsProvider);
    final homeActivityReportBenchmarkPawsState = ref.watch(homeActivityReportBenchmarkPawsProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 벤치마크 반려동물 Paws (활동량)
      ref.read(homeActivityReportBenchmarkPawsProvider.notifier).set(
        fnGetBenchmarkPaws(
          responseDogsState[homeActivatedPetNavState].pet_size, 
          fnGetDaysDiff(responseDogsState[homeActivatedPetNavState].pet_birth),
        ),
      );
    });

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '활동량 보고서',
        leadingOnPressed: () {
          if(!context.mounted) return;
          context.pop();
        },
        actionIcon: 'assets/icons/action/open_info_window.svg',
        actionOnPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const HomeActivityReportInfoDialog(),
          );
        },
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          // TODO : 상태 초기화
          
          context.pop();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0), // 필요할 경우 조정
              child: Column(
                children: [
                  const SizedBox(height: 16,),
                  // 하이라이트 - 그래프
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '하이라이트',
                          style: CustomText.heading4.copyWith(
                            color: CustomColor.blue03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Text(
                          '혹시 7시에 무슨 일이 있었나요?',
                          style: CustomText.body11.copyWith(
                            color: CustomColor.deepYellow,
                          ),
                        ),
                        Text(
                          '반려동물이 흥분을 감추지 못했어요.',
                          style: CustomText.body11.copyWith(
                            color: CustomColor.deepBlue,
                          ),
                        ),
                        const SizedBox(height: 16,),
                        AspectRatio(
                          aspectRatio: 1.8,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                maxY: 10001,
                                minY: -5,
                                barTouchData: BarTouchData(
                                  enabled: true, // 터치 활성화
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipRoundedRadius: 10,
                                    tooltipPadding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 2),
                                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                      final value = rod.toY.toInt();
                                      return BarTooltipItem(
                                        '$value Paws',
                                        CustomText.caption3.copyWith(
                                          color: CustomColor.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  leftTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 16,
                                      getTitlesWidget: (value, meta) {
                                        
                                        const style = TextStyle(
                                          color: Color(0xFF0092CA),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8,
                                        );
                    
                                        switch (value.toInt()) {
                                          case 0:
                                            return const Text('0시', style: style);
                                          case 3:
                                            return const Text('3시', style: style);
                                          case 6:
                                            return const Text('6시', style: style);
                                          case 9:
                                            return const Text('9시', style: style);
                                          case 12:
                                            return const Text('오후 12시', style: style);
                                          case 15:
                                            return const Text('15시', style: style);
                                          case 18:
                                            return const Text('18시', style: style);
                                          case 21:
                                            return const Text('21시', style: style);
                                          default:
                                            return const Text('', style: style);
                                        }
                                      },
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 32,
                                      interval: 1000,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          value.toInt() % 1000 == 0 ? value.toInt().toString() : '',
                                          style: const TextStyle(
                                            color: Color(0xFF0092CA),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 8,
                                          ),
                                          textAlign: TextAlign.right,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: true,
                                  verticalInterval: 3,
                                  horizontalInterval: 1000,
                                  getDrawingVerticalLine: (value) => FlLine(
                                    color: const Color(0xFFB7B5AF).withValues(alpha: 0.4),
                                    strokeWidth: 1,
                                  ),
                                  getDrawingHorizontalLine: (value) => FlLine(
                                    color: const Color(0xFFB7B5AF).withValues(alpha: 0.4),
                                    strokeWidth: 1,
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: false
                                ),
                                // TODO : 일별 활동량? 가져오기
                                barGroups: List.generate(highlightValues.length, (index) {
                                  return BarChartGroupData(
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        toY: highlightValues[index].toDouble(),
                                        width: 8,
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Container(
                    height: 16,
                    decoration: const BoxDecoration(
                      color: CustomColor.gray06,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  // 오늘의 활동 분석
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '오늘의 활동 분석',
                          style: CustomText.heading4.copyWith(
                            color: CustomColor.blue03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16,),
                        // 오늘의 활동 분석 1 - 누적 꺽은선 그래프
                        HomeReportContainerLayout(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '오늘은 평소보다 점수가 낮아요.',
                                style: CustomText.body11.copyWith(
                                  color: CustomColor.deepBlue,
                                ),
                              ),
                              const SizedBox(height: 8,),
                              SizedBox(
                                height: 38,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '오늘',
                                      style: CustomText.body9.copyWith(
                                        color: CustomColor.blue03,
                                      ),
                                    ),
                                    const SizedBox(width: 4,),
                                    Text(
                                      NumberFormat('###,###,###,###').format(3671),
                                      style: CustomText.heading1.copyWith(
                                        color: CustomColor.blue03,
                                      ),
                                    ),
                                    Text(
                                      'Paws',
                                      style: CustomText.body9.copyWith(
                                        color: CustomColor.blue03,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4,),
                              SizedBox(
                                height: 28,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '평균',
                                      style: CustomText.body9.copyWith(
                                        color: CustomColor.gray03,
                                      ),
                                    ),
                                    const SizedBox(width: 4,),
                                    Text(
                                      NumberFormat('###,###,###,###').format(homeActivityReportBenchmarkPawsState),
                                      style: CustomText.heading4.copyWith(
                                        color: CustomColor.gray03,
                                      ),
                                    ),
                                    Text(
                                      'Paws',
                                      style: CustomText.body9.copyWith(
                                        color: CustomColor.gray03,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8,),
                              Container(
                                height: 200,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: LineChart(
                                  LineChartData(
                                    lineTouchData: LineTouchData(
                                      getTouchedSpotIndicator:(barData, spotIndexes) {
                                        // Return an empty list or provide your custom logic here
                                        return spotIndexes.map((index) {
                                          final isFirstLine = barData.color == CustomColor.yellow03;

                                          return TouchedSpotIndicatorData(
                                            FlLine(
                                              color: isFirstLine ? CustomColor.yellow03 : CustomColor.gray05,
                                              strokeWidth: 2,
                                            ),
                                            FlDotData(
                                              getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                                color: CustomColor.white,
                                                strokeColor: isFirstLine ? CustomColor.yellow03 : CustomColor.gray05,
                                                radius: 5,
                                                strokeWidth: 2.5,
                                              ),
                                            ),
                                          );
                                        }).toList();
                                      },
                                      touchTooltipData: LineTouchTooltipData(
                                        tooltipRoundedRadius: 10,
                                        tooltipPadding: const EdgeInsets.all(8),
                                        getTooltipItems: (List<LineBarSpot> touchedSpots) {
                                          return touchedSpots.map((spot) {
                                            final value = spot.y.toInt();
                                            return LineTooltipItem(
                                              '${NumberFormat('###,###,###,###').format(value)} Paws',
                                              CustomText.body11.copyWith(
                                                color: spot.bar.color,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ),
                                    gridData: const FlGridData(show: false),
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, meta) {

                                            const style = TextStyle(
                                              color: CustomColor.gray03,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            );

                                            switch (value.toInt()) {
                                              case 0:
                                                return const Text('0시', style: style);
                                              case 24:
                                                return const Text('24시', style: style);
                                              default:
                                                return const Text('', style: style);
                                            }
                                          },
                                        ),
                                      ),
                                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    ),
                                    borderData: FlBorderData(show: false),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: fnGetCumulativePaws(petHourlyPaws),
                                        isCurved: true,
                                        color: CustomColor.yellow03,
                                        barWidth: 2,
                                        dotData: const FlDotData(show: false),
                                        belowBarData: BarAreaData(show: false),
                                        curveSmoothness: 0.0,
                                      ),
                                      LineChartBarData(
                                        spots: fnGetCumulativePaws(averageHourlyPaws),
                                        isCurved: true,
                                        color: CustomColor.gray05,
                                        barWidth: 2,
                                        dotData: const FlDotData(show: false),
                                        belowBarData: BarAreaData(show: false),
                                        curveSmoothness: 0.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16,),
                        HomeReportContainerLayout(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '탄이보다 보호자님이 더 활동적이었군요!\n탄이가 섭섭하지 않도록 활동량을 늘려주세요 :)',
                                style: CustomText.body11.copyWith(
                                  color: CustomColor.deepBlue,
                                ),
                              ),
                              const SizedBox(height: 8,),
                              SizedBox(
                                height: 200,
                                child: PieChart(
                                  PieChartData(
                                    sectionsSpace: 1,
                                    centerSpaceRadius: 50,
                                    sections: [
                                      PieChartSectionData(
                                        value: 2500,
                                        color: CustomColor.blue03,
                                        title: '',
                                        radius: 45,
                                      ),
                                      PieChartSectionData(
                                        value: 2000,
                                        color: CustomColor.gray04,
                                        title: '',
                                        radius: 45,
                                      ),
                                      PieChartSectionData(
                                        value: 3000,
                                        color: CustomColor.yellow03,
                                        title: '',
                                        radius: 45,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8,),
                              // RichText(
                              //   text: TextSpan(
                              //     text: '탄이',
                              //     style: CustomText.body11.copyWith(
                              //       color: CustomColor.blue03
                              //     ),
                              //     children: <TextSpan>[
                              //       TextSpan(text: NumberFormat(' ###,###,###,###').format(3671),),
                              //       const TextSpan(text: ' Paws'),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   width: 170,
                              //   height: 20,
                              //   margin: const EdgeInsets.only(top: 4),
                              //   padding: const EdgeInsets.symmetric(horizontal: 8),
                              //   decoration: const BoxDecoration(
                              //     color: CustomColor.blue03,
                              //     borderRadius: BorderRadius.only(
                              //       topRight: Radius.circular(20), 
                              //       bottomRight: Radius.circular(20),
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(height: 8,),
                              // RichText(
                              //   text: TextSpan(
                              //     text: '보호자님',
                              //     style: CustomText.body11.copyWith(
                              //       color: CustomColor.deepYellow,
                              //     ),
                              //     children: <TextSpan>[
                              //       TextSpan(text: NumberFormat(' ###,###,###,###').format(3671),),
                              //       const TextSpan(text: ' Paws'),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   width: 120,
                              //   height: 20,
                              //   margin: const EdgeInsets.only(top: 4),
                              //   padding: const EdgeInsets.symmetric(horizontal: 8),
                              //   decoration: const BoxDecoration(
                              //     color: CustomColor.yellow03,
                              //     borderRadius: BorderRadius.only(
                              //       topRight: Radius.circular(20), 
                              //       bottomRight: Radius.circular(20),
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(height: 8,),
                              // RichText(
                              //   text: TextSpan(
                              //     text: '동종 평균',
                              //     style: CustomText.body11.copyWith(
                              //       color: CustomColor.gray03
                              //     ),
                              //     children: <TextSpan>[
                              //       TextSpan(text: NumberFormat(' ###,###,###,###').format(3671),),
                              //       const TextSpan(text: ' Paws'),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   width: 170,
                              //   height: 20,
                              //   margin: const EdgeInsets.only(top: 4),
                              //   padding: const EdgeInsets.symmetric(horizontal: 8),
                              //   decoration: const BoxDecoration(
                              //     color: CustomColor.gray04,
                              //     borderRadius: BorderRadius.only(
                              //       topRight: Radius.circular(20), 
                              //       bottomRight: Radius.circular(20),
                              //     ),
                              //   ),
                              // ),
                              HomeHorizontalBarChartContainer(
                                text: responseDogsState.isNotEmpty ? 
                                  responseDogsState[homeActivatedPetNavState].pet_name :
                                  '반려동물',
                                textSpanList: [
                                  TextSpan(text: NumberFormat(' ###,###,###,###').format(3671),),
                                  const TextSpan(text: ' Paws'),
                                ],
                                score: 3671,
                                flag: 'activity',
                              ),
                              HomeHorizontalBarChartContainer(
                                text: '보호자님',
                                textSpanList: [
                                  TextSpan(text: NumberFormat(' ###,###,###,###').format(3671),),
                                  const TextSpan(text: ' Paws'),
                                ],
                                textColor: CustomColor.deepYellow,
                                barColor: CustomColor.yellow03,
                                score: 5000,
                                flag: 'activity',
                              ),
                              HomeHorizontalBarChartContainer(
                                text: '${fnGetDogSizeKorName(responseDogsState[homeActivatedPetNavState].pet_size)} 평균',
                                textSpanList: [
                                  TextSpan(text: NumberFormat(' ###,###,###,###').format(homeActivityReportBenchmarkPawsState),),
                                  const TextSpan(text: ' Paws'),
                                ],
                                textColor: CustomColor.gray03,
                                barColor: CustomColor.gray04,
                                score: homeActivityReportBenchmarkPawsState,
                                flag: 'activity',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


