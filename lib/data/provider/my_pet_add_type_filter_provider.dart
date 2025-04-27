import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetAddTypeFilterState extends StateNotifier<List<String>> {
  MyPetAddTypeFilterState() : super([]);

  void set(List<String> types) => state = types;

  List<String> get() => state;
}

final myPetAddTypeFilterProvider = 
  StateNotifierProvider<MyPetAddTypeFilterState, List<String>>((ref) => MyPetAddTypeFilterState());