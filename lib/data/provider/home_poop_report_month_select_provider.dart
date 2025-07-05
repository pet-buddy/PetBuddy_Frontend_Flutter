import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePoopReportMonthSelectState extends StateNotifier<int> {
  HomePoopReportMonthSelectState() : super(-1);

  int get() => state;

  void set(int value) => state = value;
}

final homePoopReportMonthSelectProvider = 
    StateNotifierProvider<HomePoopReportMonthSelectState, int>((ref) => HomePoopReportMonthSelectState());