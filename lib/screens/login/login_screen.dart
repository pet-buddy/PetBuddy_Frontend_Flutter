import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/screens/login/widget/widget.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: const DefaultAppBar(
        title: '로그인',
        leadingDisable: true,
        actionDisable: true,
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          // await fnClose(context);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 40,),
                  const Text(
                    '아직 펫버디 회원이 아니세요?',
                    style: CustomText.body4,
                  ),
                  const Text(
                    '카카오로 간편하게 시작하세요!',
                    style: CustomText.body4,
                  ),
                  const SizedBox(height: 20,),
                  LoginButton(
                    text: '카카오로 간편하게 시작하기', 
                    backgroundColor: CustomColor.kakaoYellow,
                    borderColor: CustomColor.kakaoYellow,
                    imgAsset: Image.asset(
                      'assets/icons/logo/kakao_logo.png',
                      width: 36,
                      height: 25,
                    ),
                    rightPairBox: const SizedBox(width: 36,),
                    onPressed: () {
                      // TODO : 카카오 로그인 처리
                      // 임시 경로 처리
                      context.goNamed('home_screen');
                    },
                  ),
                  /* description 
                  - 스크롤 가능한 화면일 경우, Spacer 위젯 사용 불가
                  - 위젯 높이를 대략적으로 계산하여 전체 높이에서 빼줌
                  */
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 600,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container( 
                        height: 1,
                        width: 100,
                        color:CustomColor.labelAssistiveBlack,
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        '다른 방법으로 시작',
                        style: CustomText.body4.copyWith(
                          color: CustomColor.labelAssistiveBlack
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Container( 
                        height: 1,
                        width: 100,
                        color:CustomColor.labelAssistiveBlack,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  LoginButton(
                    text: '네이버로 로그인', 
                    backgroundColor: CustomColor.naverGreen,
                    borderColor: CustomColor.naverGreen,
                    textColor: CustomColor.white,
                    imgAsset: Image.asset(
                      'assets/icons/logo/naver_logo.png',
                      width: 35,
                      height: 29,
                    ),
                    rightPairBox: const SizedBox(width: 35,),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 10,),
                  LoginButton(
                    text: 'Apple로 로그인', 
                    backgroundColor: CustomColor.appleBlack,
                    borderColor: CustomColor.appleBlack,
                    textColor: CustomColor.white,
                    imgAsset: Image.asset(
                      'assets/icons/logo/apple_logo.png',
                      width: 28,
                      height: 28,
                    ),
                    rightPairBox: const SizedBox(width: 28,),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 10,),
                  LoginButton(
                    text: '이메일 로그인',
                    borderColor: CustomColor.labelAssistiveBlack,
                    onPressed: () {
                      context.goNamed('email_login_screen');
                    },
                  ),
                  const SizedBox(height: 200,),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
