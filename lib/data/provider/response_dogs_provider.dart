import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/response_dogs_detail_model.dart';

class ResponseDogsState extends StateNotifier<List<ResponseDogsDetailModel>> {
  ResponseDogsState() : super([]);

  void set(List<ResponseDogsDetailModel> types) => state = types;

  List<ResponseDogsDetailModel> get() => state;
}

final responseDogsProvider = 
  StateNotifierProvider<ResponseDogsState, List<ResponseDogsDetailModel>>((ref) => ResponseDogsState());