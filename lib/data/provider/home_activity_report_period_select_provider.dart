import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeActivityReportPeriodSelectState extends StateNotifier<String> {
  HomeActivityReportPeriodSelectState() : super('D');

  String get() => state;

  void set(String value) => state = value;
}

final homeActivityReportPeriodSelectProvider = 
    StateNotifierProvider<HomeActivityReportPeriodSelectState, String>((ref) => HomeActivityReportPeriodSelectState());