import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePoopReportPreviousMonthSelectState extends StateNotifier<int> {
  HomePoopReportPreviousMonthSelectState() : super(-1);

  int get() => state;

  void set(int value) => state = value;
}

final homePoopReportPreviousMonthSelectProvider = 
    StateNotifierProvider<HomePoopReportPreviousMonthSelectState, int>((ref) => HomePoopReportPreviousMonthSelectState());