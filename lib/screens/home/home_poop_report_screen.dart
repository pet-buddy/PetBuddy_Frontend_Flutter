import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';

class HomePoopReportScreen extends ConsumerStatefulWidget {
  const HomePoopReportScreen({super.key});

  @override
  ConsumerState<HomePoopReportScreen> createState() => HomePoopReportScreenState();
}

class HomePoopReportScreenState extends ConsumerState<HomePoopReportScreen> with HomeController {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    List<DateTime?> selectedDay = [date];

    final config = CalendarDatePicker2WithActionButtonsConfig(
      lastDate: DateTime.now(),
      disableModePicker: true,
      modePickerBuilder: ({isMonthPicker, required monthDate, required viewMode}) {
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
      dayMaxWidth: 75,
      dayBuilder: ({required date, decoration, isDisabled, isSelected, isToday, textStyle}) {
        return SizedBox(
          height: 75,
          child: InkWell(
            splashColor: Colors.transparent, 
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              selectedDay[0] = date;
              var e = DateFormat.E("ko_KR").format(selectedDay[0]!);
              debugPrint(e);
            },
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 19,
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
                      height: 45,
                      alignment: Alignment.bottomCenter,
                      child: date.month == 6 && date.day < 10 && date.day % 2 == 0 ?
                        Image.asset(
                          "assets/icons/etc/poop_status_1.png",
                          width: 35,
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
          context.pop();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16,),
                  // 달력 영역
                  CalendarDatePicker2WithActionButtons(
                    value: selectedDay,
                    config: config,
                    onDisplayedMonthChanged: (value) async {
                    },
                  ),
                  const SizedBox(height: 16,),
                  // 월별 건강


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
