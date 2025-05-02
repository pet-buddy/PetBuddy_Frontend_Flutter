import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetAddFeedFilterState extends StateNotifier<List<String>> {
  MyPetAddFeedFilterState() : super([]);

  void set(List<String> types) => state = types;

  List<String> get() => state;
}

final myPetAddFeedFilterProvider = 
  StateNotifierProvider<MyPetAddFeedFilterState, List<String>>((ref) => MyPetAddFeedFilterState());