// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
import 'package:petbuddy_frontend_flutter/controller/controller_utils.dart';
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

      try {
        if(accessToken != null) {
          // final response = await ref.read(userRepositoryProvider).requestUserMypageRepository();

          // if(response.response_code == 200) {
          //   ResponseUserMypageModel responseUserMypageModel = ResponseUserMypageModel.fromJson(response.data);
          //   // 사용자 정보 세팅
          //   ref.read(responseUserMypageProvider.notifier).set(responseUserMypageModel);
          // }

          // 사용자 정보 세팅
          await ControllerUtils.fnGetUserMypageExec(ref, context);

          // 반려동물 정보 세팅
          await ControllerUtils.fnGetDogsExec(ref, context);

          // TODO : 홈 화면 정보 세팅

          entryPoint = 'home_screen'; 
        }
      } catch (e) {
        if(!context.mounted) return;
        showAlertDialog(
          context: context, 
          middleText: Sentence.SERVER_ERR,
        );
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
            )
          ],
        ),
      ),
    );
  }
}
