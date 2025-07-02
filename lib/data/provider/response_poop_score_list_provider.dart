import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponsePoopScoreListState extends StateNotifier<List<int>> {
  ResponsePoopScoreListState() : super([]);

  void set(List<int> timeList) {
    state = timeList;
  }

  List<int> get() => state;
}

final responsePoopScoreListProvider = 
  StateNotifierProvider<ResponsePoopScoreListState, List<int>>((ref) => ResponsePoopScoreListState());