import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      validateStatus: (status) {
        return status != null && status < 500;
      },
    )
  );

  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomInterceptor(storage: storage),
  );

  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    // 헤더 설정
    options.headers['Content-Type'] = 'application/json';
    options.connectTimeout = const Duration(seconds: 20);

    // 요청 시 토큰 처리
    final accessToken = await storage.read(key: ProjectConstant.ACCESS_TOKEN);
    final refreshToken = await storage.read(key: ProjectConstant.REFRESH_TOKEN);

    // 헤더에 토큰 삽입
    options.headers['Authorization'] = 'Bearer $accessToken';
    
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    
    String? accessToken = await storage.read(key: ProjectConstant.ACCESS_TOKEN);
    String? refreshToken = await storage.read(key: ProjectConstant.REFRESH_TOKEN);
    // 토큰이 유효하지 않을 때
    if(accessToken == null || refreshToken == null) {
      return handler.reject(err);
    }

    final statusMessage = err.response?.statusMessage;
    final statusCode = err.response?.statusCode;
    final requestPath = err.requestOptions.path;

    // TODO : 요청 URL 합의 필요, 로그인일 경우 TOKEN 재발급 요청없이 return - 401, 402, 403, 500
    if((statusCode == 401 || statusCode == 402 || statusCode == 403 || statusCode == 500) && 
       (requestPath == '/ayth/kakao/token' || requestPath == '/ayth/naver/token' || requestPath == '/user/email-login')) {
      return handler.resolve(err.response!);
    }

    // TODO : 요청 URL 합의 필요, ACCESS, REFRESH TOKEN 재발급 요청
    if((statusCode == 401 || statusCode == 402 || statusCode == 403 || statusCode == 500) && (requestPath != '/user/refresh' || (statusMessage ?? '').contains('expired'))) {
      final dio = Dio();

      try {
        final resp = await dio.post(
          '${ProjectConstant.BASE_URL}/user/refresh',
          options: Options(
            headers: {
              'Authorization': 'Bearer $refreshToken',
            },
          ),
          data: {}
        );

        CommonResponseMapModel commonResponseMapModel = CommonResponseMapModel.fromJson(resp.data);
        ResponseRefreshModel responseRefreshModel = ResponseRefreshModel.fromJson(commonResponseMapModel.data!);
        
        // 응답으로 받은 토큰 변수에 할당
        accessToken = responseRefreshModel.accessToken; // resp.data['accessToken'];
        refreshToken = responseRefreshModel.refreshToken; // resp.data['refreshToken'];
        // secure storage에 토큰 다시 저장
        await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: accessToken);
        await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: refreshToken);

        // 헤더에 토큰 삽입
        err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';

        // 요청 재전송
        final response = await dio.fetch(err.requestOptions);

        return handler.resolve(response);
      } on DioException {
        return handler.reject(err);
      }
    }

    return super.onError(err, handler);
  }
}
