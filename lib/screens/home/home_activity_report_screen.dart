import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/home_activity_report_period_select_provider.dart';
import 'package:petbuddy_frontend_flutter/screens/home/widget/widget.dart';

class HomeActivityReportScreen extends ConsumerStatefulWidget {
  const HomeActivityReportScreen({super.key});

  @override
  ConsumerState<HomeActivityReportScreen> createState() => HomeActivityReportScreenState();
}

class HomeActivityReportScreenState extends ConsumerState<HomeActivityReportScreen> with HomeController {

  @override
  void initState() {
    super.initState();
    fnInitHomeController(ref, context);
  }

  // 임시 변수
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final homeActivityReportPeriodSelectState = ref.watch(homeActivityReportPeriodSelectProvider);

    final values = [1000.0, 0.0, 1250.0, 300.0, 2000.0, 400.0, 500.0, 800.0, 
                    1000.0, 0.0, 5250.0, 300.0, 2000.0, 400.0, 1500.0, 1800.0,
                    1000.0, 0.0, 1250.0, 3600.0, 5000.0, 400.0, 5200.0, 8100.0];

    void _changeDate(int offset) {
      setState(() {
        selectedDate = selectedDate.add(Duration(days: offset));
      });
    }

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '활동량 보고서',
        leadingOnPressed: () {
          if(!context.mounted) return;
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
          // await fnClose(context);
        },
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 64,),
                      const SizedBox(height: 16,),
                      Container(
                        width: fnGetDeviceWidth(context),
                        height: 32,
                        decoration: const BoxDecoration(
                          color: CustomColor.yellow03,
                          borderRadius: BorderRadius.all(Radius.circular(8),),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                HomeActivityReportPeriodButton(
                                  width:  (fnGetDeviceWidth(context) - 4) / 6, 
                                  color:  homeActivityReportPeriodSelectState == periodCode['Day']! 
                                    ? CustomColor.white 
                                    : CustomColor.yellow03,
                                  text:  periodCode['Day']!, 
                                  onPressed: () {
                                    ref.watch(homeActivityReportPeriodSelectProvider.notifier)
                                       .set(periodCode['Day']!);
                                  }
                                ),
                                Container(
                                  width: 1,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: const BoxDecoration(
                                    color: CustomColor.gray02,
                                  ),
                                ),
                                HomeActivityReportPeriodButton(
                                  width: (fnGetDeviceWidth(context) - 4) / 6, 
                                  color: homeActivityReportPeriodSelectState == periodCode['Week']! 
                                    ? CustomColor.white 
                                    : CustomColor.yellow03,
                                  text: periodCode['Week']!, 
                                  onPressed: () {
                                    ref.watch(homeActivityReportPeriodSelectProvider.notifier)
                                       .set(periodCode['Week']!);
                                  }
                                ),
                                Container(
                                  width: 1,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: const BoxDecoration(
                                    color: CustomColor.gray02,
                                  ),
                                ),
                                HomeActivityReportPeriodButton(
                                  width: (fnGetDeviceWidth(context) - 4) / 6, 
                                  color: homeActivityReportPeriodSelectState == periodCode['Month']! 
                                    ? CustomColor.white 
                                    : CustomColor.yellow03,
                                  text: periodCode['Month']!, 
                                  onPressed: () {
                                    ref.watch(homeActivityReportPeriodSelectProvider.notifier)
                                       .set(periodCode['Month']!);
                                  }
                                ),
                                Container(
                                  width: 1,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: const BoxDecoration(
                                    color: CustomColor.gray02,
                                  ),
                                ),
                                HomeActivityReportPeriodButton(
                                  width: (fnGetDeviceWidth(context) - 4) / 6, 
                                  color: homeActivityReportPeriodSelectState == periodCode['6Month']! 
                                    ? CustomColor.white 
                                    : CustomColor.yellow03,
                                  text: periodCode['6Month']!, 
                                  onPressed: () {
                                    ref.watch(homeActivityReportPeriodSelectProvider.notifier)
                                       .set(periodCode['6Month']!);
                                  }
                                ),
                                Container(
                                  width: 1,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: const BoxDecoration(
                                    color: CustomColor.gray02,
                                  ),
                                ),
                                HomeActivityReportPeriodButton(
                                  width: (fnGetDeviceWidth(context) - 4) / 6,
                                  color: homeActivityReportPeriodSelectState == periodCode['Year']! 
                                    ? CustomColor.white 
                                    : CustomColor.yellow03, 
                                  text: periodCode['Year']!, 
                                  onPressed: () {
                                    ref.watch(homeActivityReportPeriodSelectProvider.notifier)
                                       .set(periodCode['Year']!);
                                  }
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      // 그래프
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: CustomColor.white,
                          borderRadius: const BorderRadius.all(Radius.circular(8),),
                          boxShadow: [
                            BoxShadow(
                              color: CustomColor.gray04..withValues(alpha: 0.0),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 0),
                            )
                          ],
                        ),
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
                            const Text(
                              '혹시 7시에 무슨 일이 있었나요?\n반려동물이 흥분을 감추지 못했어요.',
                              style: CustomText.body11,
                            ),
                            const SizedBox(height: 16,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/icons/navigation/calendar_arrow_back.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                  onPressed: () { 
                                    _changeDate(-1);
                                    debugPrint(selectedDate.toString());
                                  },
                                ),
                                Text(
                                  DateFormat('yyyy년 M월 d일').format(selectedDate),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/icons/navigation/calendar_arrow_next.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                  onPressed: () { 
                                    _changeDate(1);
                                    debugPrint(selectedDate.toString());
                                  }
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            AspectRatio(
                              aspectRatio: 1.8,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                child: BarChart(
                                  BarChartData(
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY: 10001,
                                    minY: -5,
                                    barTouchData: BarTouchData(enabled: false),
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
                                    barGroups: List.generate(values.length, (index) {
                                      return BarChartGroupData(
                                        x: index,
                                        barRods: [
                                          BarChartRodData(
                                            toY: values[index].toDouble(),
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
                      // 활동량 분석 
                      HomeActivityReportContainer(
                        periodCode: homeActivityReportPeriodSelectState, 
                        assessment: '탄이보다 보호자님이 더 활동적이었군요!\n탄이가 섭섭하지 않도록 활동량을 늘려주세요 :)'
                      ),
                      const SizedBox(height: 16,),
                      // 종합평가
                      HomeActivityReportTotalContainer(
                        periodCode: homeActivityReportPeriodSelectState, 
                        evaluation: '평균 노년견 푸들 대비 활동량이 낮습니다.\n보호자님이 많이 걸으신 만큼, 탄이와도 함께 많이 걸어다니세요!',
                        petName: '탄이',
                        petActivity: '대형백화점 1바퀴',
                        petActivityDistance: '0.5',
                      ),
                      const SizedBox(height: 16,),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 8,
                left: 16,
                right: 16,
                child: Container(
                  width: fnGetDeviceWidth(context),
                  height: 50,
                  decoration: BoxDecoration(
                    color: CustomColor.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        width: 1,
                        color: CustomColor.gray03,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColor.gray04..withValues(alpha: 0.0),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '해당 화면은 예시 화면입니다.',
                        style: CustomText.body9.copyWith(
                          color: CustomColor.gray02,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
