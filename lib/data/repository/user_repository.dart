import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:petbuddy_frontend_flutter/common/http/dio.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'user_repository.g.dart';


final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = UserRepository(dio, baseUrl: '${ProjectConstant.BASE_URL}/user');

  return repository;
});

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = 
    _UserRepository;

  @POST('/logout')
  Future<CommonResponseListModel> requestLogoutRepository(); 

  @PATCH('/userinfos')
  Future<CommonResponseListModel> requestUserinfosRepository(@Body() RequestUserinfosModel requestUserinfosModel); 

  @PATCH('/users')
  Future<CommonResponseListModel> requestUsersRepository(@Body() RequestUsersModel requestUsersModel); 

  @PATCH('/mypage')
  Future<CommonResponseListModel> requestMypageRepository(); 
} 
