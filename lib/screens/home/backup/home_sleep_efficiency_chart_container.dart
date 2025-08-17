import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_color.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_text.dart';

class HomeSleepEfficiencyChartContainer extends ConsumerStatefulWidget {

  const HomeSleepEfficiencyChartContainer({
    super.key,
    required this.sleepScore,
  }); 

  final List<double> sleepScore;

  @override
  ConsumerState<HomeSleepEfficiencyChartContainer> createState() => HomeSleepEfficiencyChartContainerState();
}

class HomeSleepEfficiencyChartContainerState extends ConsumerState<HomeSleepEfficiencyChartContainer> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '수면효율도 90% 이상',
              style: CustomText.caption3.copyWith(
                color: CustomColor.deepBlue,
              ),
            ),
            const SizedBox(width: 4,),
            SvgPicture.asset(
              'assets/icons/etc/status_good.svg',
              width: 16,
              height: 16,
            ),
            const SizedBox(width: 16,),
            Text(
              '수면효율도 70% 이하 ',
              style: CustomText.caption3.copyWith(
                color: CustomColor.deepBlue,
              ),
            ),
            const SizedBox(width: 4,),
            SvgPicture.asset(
              'assets/icons/etc/status_bad.svg',
              width: 16,
              height: 16,
            ),
          ],
        ),
        const SizedBox(height: 16,),
        AspectRatio(
          aspectRatio: 1.2,
          child: BarChart(
            BarChartData(
              maxY: 100.0,
              minY: 0,
              barTouchData: BarTouchData(
                enabled: true, // 터치 활성화
                touchTooltipData: BarTouchTooltipData(
                  tooltipRoundedRadius: 10,
                  tooltipPadding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final value = rod.toY.toInt();
                    return BarTooltipItem(
                      '$value %',
                      CustomText.body11.copyWith(
                        color: CustomColor.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 10,
                getDrawingHorizontalLine: (value) {
                  // if (value == 90) {
                  //   return const FlLine(
                  //     color: Color(0xFF91D834), 
                  //     strokeWidth: 1, 
                  //     dashArray: [5, 5]
                  //   );
                  // } else if (value == 70) {
                  //   return const FlLine(
                  //     color: Color(0xFFEA6176), 
                  //     strokeWidth: 1, 
                  //     dashArray: [5, 5]
                  //   );
                  // }
                  
                  return const FlLine(
                    color: CustomColor.gray05, 
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 10,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text('${value.toInt()}%',
                          style: CustomText.caption3.copyWith(
                            color: CustomColor.gray04,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const days = ['일', '월', '화', '수', '목', '금', '토'];
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          days[value.toInt()],
                          style: CustomText.body11,
                        ),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              barGroups: buildSleepVerticalBarChart(0),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> buildSleepVerticalBarChart(int? todayIndex) {
    return List.generate(widget.sleepScore.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: widget.sleepScore[index],
            width: 30,
            borderRadius: BorderRadius.circular(30),
            // 이전 코드 백업 - 현재 요일만 바 색깔을 노란색으로
            // gradient: (todayIndex ?? 0) == index
            //     ? LinearGradient(
            //         begin: Alignment.bottomCenter,
            //         end: Alignment.topCenter,
            //         colors: [CustomColor.yellow03, CustomColor.yellow03.withValues(alpha: 0.6)]
            //       )
            //     : LinearGradient(
            //         begin: Alignment.bottomCenter,
            //         end: Alignment.topCenter,
            //         colors: [CustomColor.blue03, CustomColor.blue03.withValues(alpha: 0.6)]
            //       ),
            gradient: widget.sleepScore[index] <= 70
                ? LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [CustomColor.negativeShade, CustomColor.negativeShade.withValues(alpha: 0.4)]
                  )
                : LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [CustomColor.blue03, CustomColor.blue03.withValues(alpha: 0.4)]
                  ),
          )
        ],
      );
    });
  }
}
