import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:petbuddy_frontend_flutter/common/http/dio.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'poo_repository.g.dart';


final pooRepositoryProvider = Provider<PooRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = PooRepository(dio, baseUrl: '${ProjectConstant.BASE_URL}/poo');

  return repository;
});

@RestApi()
abstract class PooRepository {
  factory PooRepository(Dio dio, {String baseUrl}) = 
    _PooRepository;

  @GET('/monthly-code')
  Future<CommonResponseMapModel> requestPooMonthlyCodeRepository(@Query("month") String month, @Query("dog_id") int dog_id); 

  @GET('/monthly-mean')
  Future<CommonResponseMapModel> requestPooMonthlyMeanRepository(@Query("month") String month, @Query("dog_id") int dog_id); 

  @GET('/daily-status')
  Future<CommonResponseListModel> requestPooDailyStatusRepository(@Query("date") String date, @Query("dog_id") int dog_id); 

} 
