import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:petbuddy_frontend_flutter/common/http/dio.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'sleep_repository.g.dart';


final sleepRepositoryProvider = Provider<SleepRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = SleepRepository(dio, baseUrl: '${ProjectConstant.BASE_URL}/sleep');

  return repository;
});

@RestApi()
abstract class SleepRepository {
  factory SleepRepository(Dio dio, {String baseUrl}) = 
    _SleepRepository;

  @GET('/hourly-status')
  Future<CommonResponseListModel> requestHourlyStatusRepository(@Query("pet_id") int pet_id);
} 
