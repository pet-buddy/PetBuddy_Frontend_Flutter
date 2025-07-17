import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/screens/my/widget/my_sub_menu_container.dart';
import 'package:url_launcher/url_launcher.dart';

class MySettingScreen extends ConsumerStatefulWidget {
  const MySettingScreen({super.key});

  @override
  ConsumerState<MySettingScreen> createState() => MySettingScreenState();
}

class MySettingScreenState extends ConsumerState<MySettingScreen> with MyController {

  @override
  void initState() {
    super.initState();
    fnInitMyController(ref, context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: CustomColor.gray05,
      appBar: DefaultAppBar(
        title: '기타 설정',
        leadingDisable: false,
        actionDisable: true,
        leadingOnPressed: () {
          context.pop();
        },
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          if(!context.mounted) return;
          context.pop();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  MySubMenuContainer(
                    menuName: '문의하기',
                    svgFlag: true,
                    svgPath: 'assets/icons/action/open_new_window.svg',
                    voidCallback: () {
                      launchUrl(Uri.parse(ProjectConstant.INQUIRY_URL));
                    },
                  ),
                  const DividedLine(),
                  MySubMenuContainer(
                    menuName: '자주 하는 질문 (FAQ)',
                    svgFlag: true,
                    svgPath: 'assets/icons/action/open_new_window.svg',
                    voidCallback: () {
                      launchUrl(Uri.parse(ProjectConstant.FAQ_URL));
                    },
                  ),
                  const DividedLine(),
                  MySubMenuContainer(
                    menuName: '로그아웃',
                    svgFlag: false,
                    svgPath: '',
                    voidCallback: () {
                      showConfirmDialog(
                        context: context, 
                        middleText: "로그아웃 하시겠습니까?", 
                        onConfirm: () async {
                          await fnLogOutExec();
                        },
                        confirmText: '로그아웃',
                        confirmBackgroundColor: CustomColor.negative,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                        showConfirmDialog(
                          context: context,
                          titleText: '정말 탈퇴 하시겠습니까?', 
                          middleText: '탈퇴 시 반려동물 건강기록(걸음 수, 똥 건강, 수면효율, 곳간)이 삭제됩니다.', 
                          onConfirm: () async {
                            await fnSignOutExec();
                          },
                          confirmText: '탈퇴하기',
                          confirmBackgroundColor: CustomColor.negative,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 56,
                            child: Text(
                              '탈퇴하기',
                              style: CustomText.caption2.copyWith(
                                color: CustomColor.gray03,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}