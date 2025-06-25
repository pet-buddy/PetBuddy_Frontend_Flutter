import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetAddFeedTimeListState extends StateNotifier<List<String>> {
  MyPetAddFeedTimeListState() : super([]);

  void set(List<String> timeList) => state = timeList;

  List<String> get() => state;

  void add(String elem) {
    state = [...state, elem];
  }

  void remove(String elem) {
    state = state.where((e) => e != elem).toList();
  }

  void removeAt(int index) {
    final newList = [...state]..removeAt(index);
    state = newList;
  }

  void removeMultipleAt(List<int> indices) {
    state = state.asMap()
                 .entries
                 .where((e) => !indices.contains(e.key))
                 .map((e) => e.value)
                 .toList();
  }

  void updateAt(int index, String newValue) {
    final updated = [...state];
    if (index >= 0 && index < updated.length) {
      updated[index] = newValue;
      state = updated;
    }
  }
}

final myPetAddFeedTimeListProvider = 
  StateNotifierProvider<MyPetAddFeedTimeListState, List<String>>((ref) => MyPetAddFeedTimeListState());