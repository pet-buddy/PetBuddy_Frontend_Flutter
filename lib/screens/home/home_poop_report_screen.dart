import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/home_poop_report_month_select_provider.dart';

class HomePoopReportScreen extends ConsumerStatefulWidget {
  const HomePoopReportScreen({super.key});

  @override
  ConsumerState<HomePoopReportScreen> createState() => HomePoopReportScreenState();
}

class HomePoopReportScreenState extends ConsumerState<HomePoopReportScreen> with HomeController {

  @override
  void initState() {
    super.initState();
    fnInitHomeController(ref, context);
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    List<DateTime?> selectedDay = [date];

    final homePoopReportMonthSelectState = ref.watch(homePoopReportMonthSelectProvider);

    // 임시 변수
    final values = [60.0, 75.0, 75.0, 100.0, 58.0, 76.0, 84.0, 80.0, 100.0, 100.0, 0.0, 10.0];

    final config = CalendarDatePicker2WithActionButtonsConfig(
      lastDate: DateTime.now(),
      disableModePicker: true,
      modePickerBuilder: ({isMonthPicker, required monthDate, required viewMode}) {

        WidgetsBinding.instance.addPostFrameCallback((_) {
          // 활성화된 월 저장
          ref.read(homePoopReportMonthSelectProvider.notifier).set(monthDate.month);
        });

        var calendarTitle = Container(
          alignment: Alignment.center,
          width: 106,
          height: 29,
          decoration: BoxDecoration(
            color: CustomColor.yellow03,
            borderRadius: BorderRadius.circular(8.0),
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
        return SizedBox(
          height: 60,
          child: InkWell(
            splashColor: Colors.transparent, 
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              selectedDay[0] = date;
              var e = DateFormat.E("ko_KR").format(selectedDay[0]!);
              // debugPrint(e);
            },
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                    child: Text(
                      date.day.toString(),
                      style: CustomText.body10.copyWith(
                        color: CustomColor.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: Container(
                      height: 42,
                      alignment: Alignment.bottomCenter,
                      child: date.month == 6 && date.day < 10 && date.day % 2 == 0 ?
                        Image.asset(
                          "assets/icons/etc/poop_status_1.png",
                          width: 30,
                          height: 41,
                        ) : const SizedBox(),
                    ),
                  ),
                ],
              ),
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
                  CalendarDatePicker2WithActionButtons(
                    value: selectedDay,
                    config: config,
                    onDisplayedMonthChanged: (value) async {
                    },
                  ),
                  // const SizedBox(height: 32,),
                  // 월별 건강
                  Text(
                    '$homePoopReportMonthSelectState월 똥 건강 종합보고서',
                    style: CustomText.body7.copyWith(
                      color: const Color(0xFF002C64),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Container(
                    height: 500,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: const BoxDecoration(
                      color: CustomColor.white,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16,),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              margin: const EdgeInsets.only(top: 12),
                              child: Text(
                                '종합',
                                style: CustomText.body9.copyWith(
                                  color: const Color(0xFF00467E),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 210,
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
                                                    color: const Color(0xFF00467E),
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
                                                    color: const Color(0xFF00467E),
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
                                                    color: const Color(0xFF00467E),
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
                                  // TODO : 점수 받아오기
                                  // 점수를 가리킬 아래 화살표
                                  Positioned(
                                    top: 0,
                                    left: 70 - 5,
                                    child: CustomPaint(
                                      size: const Size(10, 14), // 캔버스 크기
                                      painter: InvertedTrianglePainter(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            // TODO : 점수 받아오기
                            Text(
                              '70',
                              style: CustomText.heading1.copyWith(
                                color: const Color(0xFF00467E),
                              ),
                            ),
                            const SizedBox(width: 4,),
                            Text(
                              '점',
                              style: CustomText.body9.copyWith(
                                color: const Color(0xFF00467E),
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
                                    color: const Color(0xFF00467E),
                                  ),
                                ),
                                const SizedBox(height: 4,),
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF63C728),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '수분',
                                  style: CustomText.caption3.copyWith(
                                    color: const Color(0xFF00467E),
                                  ),
                                ),
                                const SizedBox(height: 4,),
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF6D72E),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '기생충 여부',
                                  style: CustomText.caption3.copyWith(
                                    color: const Color(0xFF00467E),
                                  ),
                                ),
                                const SizedBox(height: 4,),
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF63C728),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        // TODO : 월별 점수 정보 받아오기
                        AspectRatio(
                          aspectRatio: 1.8,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                maxY: 110,
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
                                          default:
                                            return Text('${value.toInt()+1}월', style: style);
                                        }
                                      },
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 16,
                                      interval: 10,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          value.toInt() % 50 == 0 ? value.toInt().toString() : '',
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
                                  drawVerticalLine: false,
                                  horizontalInterval: 10,
                                  getDrawingHorizontalLine: (value) => FlLine(
                                    color: const Color(0xFFB7B5AF).withValues(alpha: 0.4),
                                    strokeWidth: 1,
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: false
                                ),
                                // TODO : 월별 똥 분석 점수 가져오기
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InvertedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0092CA)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0); // 왼쪽 상단
    path.lineTo(size.width, 0); // 오른쪽 상단
    path.lineTo(size.width / 2, size.height); // 아래 중앙
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}