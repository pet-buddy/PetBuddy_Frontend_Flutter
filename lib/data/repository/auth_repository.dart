import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:petbuddy_frontend_flutter/common/http/dio.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_repository.g.dart';


final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = AuthRepository(dio, baseUrl: '${ProjectConstant.BASE_URL}/auth');

  return repository;
});

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String baseUrl}) = 
    _AuthRepository;

  @GET('/kakao/token')
  Future<CommonResponseListModel> requestKakaoLoginRepository(@Query("code") String code);

  @GET('/naver/token')
  Future<CommonResponseListModel> requestNaverLoginRepository(@Query("code") String code);

  @POST('/email')
  Future<CommonResponseMapModel> requestEmailRegisterRepository(@Body() RequestEmailRegisterModel requestEmailRegisterModel); 
} 
