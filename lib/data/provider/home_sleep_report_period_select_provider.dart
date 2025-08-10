import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeSleepReportPeriodSelectState extends StateNotifier<String> {
  HomeSleepReportPeriodSelectState() : super('D');

  String get() => state;

  void set(String value) => state = value;
}

final homeSleepReportPeriodSelectProvider = 
    StateNotifierProvider<HomeSleepReportPeriodSelectState, String>((ref) => HomeSleepReportPeriodSelectState());