import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:petbuddy_frontend_flutter/common/http/dio.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'pet_v2_repository.g.dart';


final petV2RepositoryProvider = Provider<PetV2Repository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = PetV2Repository(dio, baseUrl: '${ProjectConstant.BASE_URL}/v2/dog');

  return repository;
});

@RestApi()
abstract class PetV2Repository {
  factory PetV2Repository(Dio dio, {String baseUrl}) = 
    _PetV2Repository;

  @GET('/dogs')
  Future<CommonResponseMapModel> requestDogsRepository();
} 
