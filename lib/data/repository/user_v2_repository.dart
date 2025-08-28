import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:petbuddy_frontend_flutter/common/http/dio.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'user_v2_repository.g.dart';


final userV2RepositoryProvider = Provider<UserV2Repository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = UserV2Repository(dio, baseUrl: '${ProjectConstant.BASE_URL}/v2/user');

  return repository;
});

@RestApi()
abstract class UserV2Repository {
  factory UserV2Repository(Dio dio, {String baseUrl}) = 
    _UserV2Repository;

  @GET('/mypage')
  Future<CommonResponseMapModel> requestUserMypageRepository();
} 
