import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';

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

  PageController homeScreenPetController = PageController(initialPage: 0);

  void fnInvalidateHomePoopReportState() {
    homeRef.invalidate(homeActivityReportPeriodSelectProvider);
  }
}
