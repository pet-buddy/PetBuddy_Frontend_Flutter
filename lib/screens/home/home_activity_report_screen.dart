import 'dart:io';

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fnGetUserStep();
    });
  }

  // 사용자(보호자) 걸음 수 가져오기 위한 패키지
  final health = Health();

  Future<void> fnGetUserStep() async {
    // 웹 브라우저일 경우 DB에 저장된 사용자 Paws 점수 불러오기
    if(kIsWeb) {
      await fnGetUserPawsExec();
      return;
    }

    await health.configure();

    // 1) 활동 인식(런타임) 권한
    if (Platform.isAndroid) {
      final ar = await Permission.activityRecognition.request();
      // debugPrint('AR permission: ${ar.isGranted}');
      if (!ar.isGranted) {
        ref.read(homeActivityReportUserPawsProvider.notifier).set(0);
        await fnSetUserPawsExec(0);
        return;
      }
    }

    final types = [HealthDataType.STEPS];
    final perms  = [HealthDataAccess.READ];

    // 2) Health Connect 읽기 권한 보유 여부
    final has = await health.hasPermissions(types, permissions: perms);
    // debugPrint('HC hasPermissions(STEPS READ) = $has');

    if (has != true) {
      final ok = await health.requestAuthorization(types, permissions: perms);
      // debugPrint('HC requestAuthorization -> $ok');
      if(!ok) {
        ref.read(homeActivityReportUserPawsProvider.notifier).set(0);
        await fnSetUserPawsExec(0);
        return;
      }
    }

    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);

    // 3) 우선 합계 API 시도
    final total = await health.getTotalStepsInInterval(start, now);
    // debugPrint('getTotalStepsInInterval(today) = $total');
    ref.read(homeActivityReportUserPawsProvider.notifier).set((total ?? 0).toDouble());
    await fnSetUserPawsExec((total ?? 0));

    // 4) 합계가 0/NULL이면, 원시 레코드 조회해서 직접 합산 (원인 진단에 유용)
    if ((total ?? 0) == 0) {
      final points = await health.getHealthDataFromTypes(startTime: start, endTime: now, types: [HealthDataType.STEPS]);
      // debugPrint('raw step records count = ${points.length}');

      // 원시 레코드 안에 sourceName으로 공급자(Samsung Health/Watch 등)도 확인 가능
      // 첫 3개만 로그로 찍어보자
      /* for (final p in points.take(3)) {
        debugPrint('record: ${p.value} from ${p.sourceName}/(${p.type}) @ ${p.dateFrom}~${p.dateTo}');
      } */

      // value 합산
      final sum = points.fold<double>(0.0, (acc, p) {
        final v = (p.value is num) ? (p.value as num).toDouble() : 0.0;
        return acc + v;
      }).toInt();

      debugPrint('manual sum of records = $sum');
      // return sum;
      ref.read(homeActivityReportUserPawsProvider.notifier).set(sum.toDouble());
      await fnSetUserPawsExec(sum);
    }
    // 나중에 사용할 다이얼로그
    /* showAlertDialog(
      context: context, 
      middleText: "접근 권한이 거부되어 걸음 수를 가져올 수 없습니다.\n설정에서 권한을 허용해주세요.",
      onConfirm: () {
        openAppSettings();
      },
      buttonText: "확인",
    ); */

    /* showAlertDialog(
      context: context, 
      middleText: "걸음 수를 가져오던 중 오류가 발생했습니다.",
      buttonText: "확인",
    ); */
  }

  @override
  Widget build(BuildContext context) {
    // final homeActivityReportPeriodSelectState = ref.watch(homeActivityReportPeriodSelectProvider);
    final homeActivatedPetNavState = ref.watch(homeActivatedPetNavProvider);
    final responseDogsState = ref.watch(responseDogsProvider);
    final homeActivityReportUserPawsState = ref.watch(homeActivityReportUserPawsProvider);
    // final homeActivityReportPawsState = ref.watch(homeActivityReportPawsProvider); // -> homeActivityHourlyValueSumState으로 대체
    final homeActivityReportBenchmarkPawsState = ref.watch(homeActivityReportBenchmarkPawsProvider);
    final homeActivityHourlyValueListState = ref.watch(homeActivityHourlyValueListProvider);
    final homeActivityHourlyValueSumState = ref.watch(homeActivityHourlyValueSumProvider);

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
          // Provider 초기화
          fnInvalidateHomeActivityReportState();
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
                                barGroups: List.generate(homeActivityHourlyValueListState.length, (index) {
                                  return BarChartGroupData(
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        toY: homeActivityHourlyValueListState[index].toDouble(),
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
                                      NumberFormat('###,###,###,###').format(homeActivityHourlyValueSumState),
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
                              // SizedBox(
                              //   height: 28,
                              //   child: Row(
                              //     crossAxisAlignment: CrossAxisAlignment.end,
                              //     children: [
                              //       Text(
                              //         '평균',
                              //         style: CustomText.body9.copyWith(
                              //           color: CustomColor.gray03,
                              //         ),
                              //       ),
                              //       const SizedBox(width: 4,),
                              //       Text(
                              //         NumberFormat('###,###,###,###').format(0.0), // 현재 반려동물의 활동량 평균
                              //         style: CustomText.heading4.copyWith(
                              //           color: CustomColor.gray03,
                              //         ),
                              //       ),
                              //       Text(
                              //         'Paws',
                              //         style: CustomText.body9.copyWith(
                              //           color: CustomColor.gray03,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
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
                                        spots: fnGetCumulativePaws(
                                          fnGetCumulativeActivityHourlyValues(homeActivityHourlyValueListState),
                                        ),
                                        isCurved: true,
                                        color: CustomColor.yellow03,
                                        barWidth: 2,
                                        dotData: const FlDotData(show: false),
                                        belowBarData: BarAreaData(show: false),
                                        curveSmoothness: 0.0,
                                      ),
                                      // LineChartBarData(
                                      //   spots: fnGetCumulativePaws(averageHourlyPaws),
                                      //   isCurved: true,
                                      //   color: CustomColor.gray05,
                                      //   barWidth: 2,
                                      //   dotData: const FlDotData(show: false),
                                      //   belowBarData: BarAreaData(show: false),
                                      //   curveSmoothness: 0.0,
                                      // ),
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
                                        value: homeActivityHourlyValueSumState,
                                        color: CustomColor.blue03,
                                        title: '',
                                        radius: 45,
                                      ),
                                      PieChartSectionData(
                                        value: homeActivityReportBenchmarkPawsState,
                                        color: CustomColor.gray04,
                                        title: '',
                                        radius: 45,
                                      ),
                                      PieChartSectionData(
                                        value: homeActivityReportUserPawsState,
                                        color: CustomColor.yellow03,
                                        title: '',
                                        radius: 45,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8,),
                              HomeHorizontalBarChartContainer(
                                text: responseDogsState.isNotEmpty ? 
                                  responseDogsState[homeActivatedPetNavState].pet_name :
                                  '반려동물',
                                textSpanList: [
                                  TextSpan(text: NumberFormat(' ###,###,###,###').format(homeActivityHourlyValueSumState),),
                                  const TextSpan(text: ' Paws'),
                                ],
                                score: homeActivityHourlyValueSumState,
                                flag: 'activity',
                              ),
                              HomeHorizontalBarChartContainer(
                                text: '보호자님',
                                textSpanList: [
                                  TextSpan(text: NumberFormat(' ###,###,###,###').format(homeActivityReportUserPawsState),),
                                  const TextSpan(text: ' Paws'),
                                ],
                                textColor: CustomColor.deepYellow,
                                barColor: CustomColor.yellow03,
                                score: homeActivityReportUserPawsState,
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


