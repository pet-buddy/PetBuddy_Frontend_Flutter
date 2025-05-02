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

  final repository = PetRepository(dio, baseUrl: '${ProjectConstant.BASE_URL}/');

  return repository;
});

@RestApi()
abstract class PetRepository {
  factory PetRepository(Dio dio, {String baseUrl}) = 
    _PetRepository;

  @GET('/dog/dogs')
  Future<CommonResponseListModel> requestDogsRepository(); 
} 
