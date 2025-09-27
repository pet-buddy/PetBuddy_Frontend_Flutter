import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:petbuddy_frontend_flutter/common/http/dio.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'activity_repository.g.dart';


final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = ActivityRepository(dio, baseUrl: '${ProjectConstant.BASE_URL}/activity');

  return repository;
});

@RestApi()
abstract class ActivityRepository {
  factory ActivityRepository(Dio dio, {String baseUrl}) = 
    _ActivityRepository;

  @GET('/hourly-status')
  Future<CommonResponseListModel> requestHourlyStatusRepository(@Query("pet_id") int pet_id);

  @GET('/daily-status')
  Future<CommonResponseListModel> requestDailyStatusRepository(@Query("pet_id") int pet_id);

  @GET('/monthly-mean')
  Future<CommonResponseListModel> requestMonthlyMeanRepository(@Query("pet_id") int pet_id);
} 
