// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
import 'package:petbuddy_frontend_flutter/controller/controller_utils.dart';
import 'package:petbuddy_frontend_flutter/data/model/response_user_mypage_model.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
import 'package:petbuddy_frontend_flutter/route/go_security_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:petbuddy_frontend_flutter/data/model/response_user_mypage_model.dart';
// import 'package:petbuddy_frontend_flutter/data/provider/response_user_mypage_provider.dart';
// import 'package:petbuddy_frontend_flutter/data/repository/user_repository.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 이동할 화면 변수
      String entryPoint = 'login_screen'; 
      // 기기 임시저장소 Provider 불러오기
      final storage = ref.watch(secureStorageProvider);
      // accessToken 
      final accessToken = await storage.read(key: ProjectConstant.ACCESS_TOKEN);

      
      if(accessToken != null) {
        // final response = await ref.read(userRepositoryProvider).requestUserMypageRepository();

        // if(response.response_code == 200) {
        //   ResponseUserMypageModel responseUserMypageModel = ResponseUserMypageModel.fromJson(response.data);
        //   // 사용자 정보 세팅
        //   ref.read(responseUserMypageProvider.notifier).set(responseUserMypageModel);
        // }

        final prefs = await SharedPreferences.getInstance();

        bool userMyPageResult = false; // 사용자 화면 조회 결과 변수 
        bool dogsResult = false; // 강아지 조회 결과 변수

        // 웹의 Local storage에 저장된 사용자 정보 삭제
        await prefs.remove('responseUserMypage');
        ref.read(responseUserMypageProvider.notifier).set(ResponseUserMypageModel(
          user_id: -1,
          user_name: null,
          email: "",
          user_password: "",
          gender: null,
          interest: null,
          sign_route: null,
          address: null,
          remark: null,
          birth: null,
          created_at: "",
          updated_at: null,
          createdAt: "",
          updatedAt: null,
        ));
        // 웹의 Local storage에 저장된 반려동물 정보 삭제
        await prefs.remove('responseDogs');
        ref.read(responseDogsProvider.notifier).set([]);
        
        try {
          // 사용자 정보 조회
          userMyPageResult = await ControllerUtils.fnGetUserMypageExec(ref, context);
        } catch (e) {
          await ControllerUtils.fnInitAppState(ref);
          context.goNamed(entryPoint); // 로그인 화면 이동
          return;
        }
        
        if(!userMyPageResult) {
          await ControllerUtils.fnInitAppState(ref);
          context.goNamed(entryPoint); // 로그인 화면 이동
          return;
        }

        try {
          // 반려동물 정보 조회
          dogsResult = await ControllerUtils.fnGetDogsExec(ref, context);
        } catch (e) {
          await ControllerUtils.fnInitAppState(ref);
          context.goNamed(entryPoint); // 로그인 화면 이동
          return;
        }

        if(!dogsResult) {
          await ControllerUtils.fnInitAppState(ref);
          context.goNamed(entryPoint); // 로그인 화면 이동
          return;
        }

        // 활성화된 반려동물 인덱스 불러오기
        final petActivatedIndex = await storage.read(key: ProjectConstant.PET_ACTIVATED_INDEX);
        if (petActivatedIndex != null) {
          ref.read(homeActivatedPetNavProvider.notifier).set(
            int.parse(petActivatedIndex)
          );
        }

        // 라우터 처리를 위한 상태 갱신
        ref.read(goSecurityProvider.notifier).set(true); 

        // TODO : 홈 화면 정보 세팅

        entryPoint = 'home_screen'; 

      } else {
        await ControllerUtils.fnInitAppState(ref);
      }
      

      // 2초 후 화면 이동
      await Future.delayed(const Duration(milliseconds: 2000), () {
        context.goNamed(entryPoint);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/logo/app_logo_1.svg',
              width: 174.88,
              height: 100,
            ),
            const SizedBox(height: 16,),
            const CircularProgressIndicator(
              color: CustomColor.blue03,
            ),
            // PawLoadingDialog(),
          ],
        ),
      ),
    );
  }
}
