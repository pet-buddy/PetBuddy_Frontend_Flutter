import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';


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
          await fnClose(context);
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
                    'PawPrint와 함께 발자취를 남겨봐요!',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 20,),
                  // LoginButton(
                  //   text: '카카오 로그인', 
                  //   backgroundColor: CustomColor.kakaoYellow,
                  //   borderColor: CustomColor.kakaoYellow,
                  //   svgPicture: SvgPicture.asset(
                  //     'assets/icons/logo/kakao_logo.svg',
                  //     width: 24,
                  //     height: 24,
                  //   ),
                  //   rightPairBox: const SizedBox(width: 36,),
                  //   onPressed: () {
                  //     // TODO : 카카오 로그인 처리
                  //     // 임시 경로 처리
                  //     context.goNamed('home_screen');
                  //   },
                  //   disabled: false,
                  // ),
                  /* description 
                  - 스크롤 가능한 화면일 경우, Spacer 위젯 사용 불가
                  - 위젯 높이를 대략적으로 계산하여 전체 높이에서 빼줌
                  */
                  /* SizedBox(
                    height: MediaQuery.of(context).size.height - 600,
                  ), */
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container( 
                        height: 1,
                        width: 100,
                        color:CustomColor.gray04,
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        '다른 방법으로 시작',
                        style: CustomText.body10.copyWith(
                          color: CustomColor.gray02
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Container( 
                        height: 1,
                        width: 100,
                        color:CustomColor.gray04,
                      ),
                    ],
                  ), */
                  // const SizedBox(height: 10,),
                  // LoginButton(
                  //   text: '네이버 로그인', 
                  //   backgroundColor: CustomColor.naverGreen,
                  //   borderColor: CustomColor.naverGreen,
                  //   textColor: CustomColor.white,
                  //   svgPicture: SvgPicture.asset(
                  //     'assets/icons/logo/naver_logo.svg',
                  //     width: 24,
                  //     height: 24,
                  //   ),
                  //   rightPairBox: const SizedBox(width: 35,),
                  //   onPressed: () {},
                  //   disabled: false,
                  // ),
                  /* const SizedBox(height: 10,), */
                  /* LoginButton(
                    text: 'Apple 로그인', 
                    backgroundColor: CustomColor.appleBlack,
                    borderColor: CustomColor.appleBlack,
                    textColor: CustomColor.white,
                    svgPicture: SvgPicture.asset(
                      'assets/icons/logo/apple_logo.svg',
                      width: 24,
                      height: 24,
                    ),
                    rightPairBox: const SizedBox(width: 28,),
                    onPressed: () {},
                    disabled: false,
                  ), */
                  // const SizedBox(height: 10,),
                  DefaultTextButton(
                    text: '이메일 로그인',
                    borderColor: CustomColor.gray04,
                    textColor: CustomColor.black,
                    backgroundColor: CustomColor.white,
                    onPressed: () {
                      context.pushNamed('email_login_screen');
                    },
                    disabled: false,
                  ),
                  const SizedBox(height: 32,),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
