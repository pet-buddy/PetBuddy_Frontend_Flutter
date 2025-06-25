import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetAddFeedTimeDeleteListState extends StateNotifier<List<int>> {
  MyPetAddFeedTimeDeleteListState() : super([]);

  void set(List<int> deleteTimeList) => state = deleteTimeList;

  List<int> get() => state;

  void add(int elem) {
    state = [...state, elem];
  }

  void remove(int elem) {
    state = state.where((e) => e != elem).toList();
  }

  void removeAt(int index) {
    final newList = [...state]..removeAt(index);
    state = newList;
  }
}

final myPetAddFeedTimeDeleteListProvider = 
  StateNotifierProvider<MyPetAddFeedTimeDeleteListState, List<int>>((ref) => MyPetAddFeedTimeDeleteListState());