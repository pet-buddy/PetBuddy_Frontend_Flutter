import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';
import 'package:petbuddy_frontend_flutter/data/model/model.dart';

class HomeSleepCircleChartContainer extends ConsumerStatefulWidget {

  const HomeSleepCircleChartContainer({
    super.key,
    required this.title,
    required this.time,
    required this.sleepTime,
  }); 

  final String title;
  final String time; 
  final List<HomeSleepTimeRangeModel> sleepTime;

  @override
  ConsumerState<HomeSleepCircleChartContainer> createState() => HomeSleepCircleChartContainerState();
}

class HomeSleepCircleChartContainerState extends ConsumerState<HomeSleepCircleChartContainer> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "12", 
          style: CustomText.body11.copyWith(
            color: CustomColor.gray03,
          ),
        ),
        CustomPaint(
          size: const Size(150, 150),
          painter: SleepCirclePainter(
            baseGradientColors: [
              CustomColor.gray03.withValues(alpha: 0.2),
              CustomColor.gray03.withValues(alpha: 0.2),
              // TODO : 그라데이션 적용 여부 결정
              // CustomColor.gray03.withValues(alpha: 0.4),
              // CustomColor.gray03.withValues(alpha: 0.6),
              // CustomColor.gray03.withValues(alpha: 1.0),
            ],
            ranges: widget.sleepTime,
          ),
          child: SizedBox(
            width: 150,
            height: 150,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: CustomText.body10.copyWith(
                      color: CustomColor.gray04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.time,
                    style: CustomText.caption3.copyWith(
                      color: CustomColor.gray04,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Text(
          "06", 
          style: CustomText.body11.copyWith(
            color: CustomColor.gray03,
          ),
        ),
      ],
    );
  }
}

class SleepCirclePainter extends CustomPainter {
  final List<HomeSleepTimeRangeModel> ranges;
  final List<Color> baseGradientColors;

  SleepCirclePainter({
    required this.baseGradientColors,
    required this.ranges,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 20;
    final Rect rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final Paint basePaint = Paint()
      ..shader = SweepGradient(
        colors: baseGradientColors,
        startAngle: pi/2,
        endAngle: pi*2,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // 전체 회색 원
    canvas.drawArc(rect, pi/2, pi*2, false, basePaint);

    // 구간별 색칠
    for (var range in ranges) {
      final Paint rangePaint = Paint()
        ..color = range.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      double startAngle = pi / 2 + (2 * pi * range.start);
      double sweepAngle = pi * 2 * (range.end - range.start);

      canvas.drawArc(rect, startAngle, sweepAngle, false, rangePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
