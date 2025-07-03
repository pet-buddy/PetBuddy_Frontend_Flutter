import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponsePoopScoreListState extends StateNotifier<List<double>> {
  ResponsePoopScoreListState() : super([]);

  void set(List<double> timeList) {
    state = timeList;
  }

  List<double> get() => state;
}

final responsePoopScoreListProvider = 
  StateNotifierProvider<ResponsePoopScoreListState, List<double>>((ref) => ResponsePoopScoreListState());