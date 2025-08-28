// ignore_for_file: use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
import 'package:petbuddy_frontend_flutter/controller/controller_utils.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
import 'package:petbuddy_frontend_flutter/route/go_security_provider.dart';
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

      if(kIsWeb) {
        await ControllerUtils.fnInitAppState(ref); // flutter_secure_storage 삭제
        await ControllerUtils.fnInvalidateAllState(ref); // provider invalidate
        // 웹 -> shared_preferences 삭제
        await ControllerUtils.fnDeleteLocalStorage();
        // 활성화  반려동물 인덱스 0으로 세팅
        await storage.write(key: ProjectConstant.PET_ACTIVATED_INDEX, value: '0');
        ref.read(homeActivatedPetNavProvider.notifier).set(0);
      } 
      
      if(!kIsWeb){
        // accessToken 
        final accessToken = await storage.read(key: ProjectConstant.ACCESS_TOKEN);

        // 토큰이 있을 경우
        if(accessToken != null) {
          bool fetchSuccess = await fnFetchDataAndSetupApp(ref, context);

          // TODO : 홈 화면 추가 정보 세팅

          if(fetchSuccess) {
            entryPoint = 'home_screen';
          } else {
            await ControllerUtils.fnInitAppState(ref); // flutter_secure_storage 삭제
            await ControllerUtils.fnInvalidateAllState(ref); // provider invalidate
          }
        }
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

  Future<bool> fnFetchDataAndSetupApp(WidgetRef ref, BuildContext context) async {
    bool fetchResult = false;

    try {
      // 사용자 정보 조회
      bool userMyPageResult = await ControllerUtils.fnGetUserMypageExec(ref, context);
      if (!userMyPageResult) return false;

      // 반려동물 정보 조회
      bool dogsResult = await ControllerUtils.fnGetDogsExec(ref, context);
      if (!dogsResult) return false;

      final storage = ref.watch(secureStorageProvider);

      // 활성화된 반려동물 인덱스 불러오기
      final petActivatedIndex = await storage.read(key: ProjectConstant.PET_ACTIVATED_INDEX);
      if (petActivatedIndex != null) {
        final dogsCount = ref.read(responseDogsProvider.notifier).get().length;
        int activatedIndex = int.parse(petActivatedIndex) <= dogsCount ? int.parse(petActivatedIndex) : 0;

        ref.read(homeActivatedPetNavProvider.notifier).set(activatedIndex);
      }

      // 라우터 처리를 위한 상태 갱신
      ref.read(goSecurityProvider.notifier).set(true);

      fetchResult = true;
    } catch (e) {
      debugPrint("========== fnFetchDataAndSetupApp Exception ==========");
      debugPrint(e.toString());

      fetchResult = true;
    }

    return fetchResult;
  }
}
