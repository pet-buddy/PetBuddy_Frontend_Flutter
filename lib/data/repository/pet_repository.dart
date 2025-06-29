import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:petbuddy_frontend_flutter/common/http/dio.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'pet_repository.g.dart';


final petRepositoryProvider = Provider<PetRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = PetRepository(dio, baseUrl: '${ProjectConstant.BASE_URL}/dog');

  return repository;
});

@RestApi()
abstract class PetRepository {
  factory PetRepository(Dio dio, {String baseUrl}) = 
    _PetRepository;

  @GET('/dogs')
  Future<CommonResponseMapModel> requestDogsRepository(); 

  @POST('/newdog')
  Future<CommonResponseMapModel> requestNewDogRepository(@Body() RequestNewDogModel requestNewDogModel); 

  @PATCH('/update')
  Future<CommonResponseMapModel> requestUpdateDogRepository(@Query("pet_id") int pet_id, @Body() RequestUpdateDogModel requestUpdateDogModel); 

  @DELETE('/delete')
  Future<CommonResponseMapModel> requestDogDeleteRepository(@Query("dog") String dog);
} 
