import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_color.dart';

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

  // Widget을 리턴하는 함수의 prefix : wg
  Widget wgActivityReportPeriodSelectContent(double width, Color color, String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(8),),
        ),
        child: Text(
          text
        ),
      ),
    );
  }
}
