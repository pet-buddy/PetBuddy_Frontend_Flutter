import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/response_user_mypage_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyScreen extends ConsumerStatefulWidget {
  const MyScreen({super.key});

  @override
  ConsumerState<MyScreen> createState() => MyScreenState();
}

class MyScreenState extends ConsumerState<MyScreen> with MyController {

  // 마이페이지 - 회사정보섹션 높이를 구하기 위한 섹션별 키 
  GlobalKey sectionKey1 = GlobalKey();
  GlobalKey sectionKey2 = GlobalKey();
  GlobalKey sectionKey3 = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // TODO : ref로 상태관리
      setState(() {
        companySectionHeight = MediaQuery.of(context).size.height 
                                - fnGetSize(sectionKey1).height
                                - fnGetSize(sectionKey2).height
                                - fnGetSize(sectionKey3).height
                                - 32 // 중간 공백 등
                                - 50 // 앱바
                                - 50; // 네비게이션바
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final responseUserMypageState = ref.watch(responseUserMypageProvider);

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '마이페이지',
        leadingDisable: true,
        actionIcon: 'assets/icons/system/settings.svg',
        actionOnPressed: () {
          context.goNamed('my_setting_screen');
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    key: sectionKey1,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: InkWell(
                      onTap: () {
                        context.goNamed('my_profile_update_screen');
                      },
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SizedBox(
                        height: 64,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Text(
                                  '안녕하세요!',
                                  style: CustomText.body10.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  responseUserMypageState.email != "" ? 
                                    responseUserMypageState.email :
                                    "example@pawprint.ai.kr",
                                  style: CustomText.body10
                                ),
                              ],
                            ),
                            SvgPicture.asset(
                              'assets/icons/navigation/arrow_next.svg',
                              width: 24,
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 8,
                    decoration: const BoxDecoration(
                      color: CustomColor.gray05
                    ),
                  ),
                  Padding(
                    key: sectionKey2,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16,),
                        Text(
                          '선택된 반려동물',
                          style: CustomText.body10.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        // TODO : 반려동물 리스트 불러오기
                        DefaultTextButton(
                          text: '+',
                          borderColor: CustomColor.gray04,
                          backgroundColor: CustomColor.white,
                          disabled: false,
                          height: 40,
                          onPressed: () {
                            context.goNamed('my_pet_add_screen');
                          },
                        ),
                        const SizedBox(height: 16,),
                      ],
                    ),
                  ),
                  Container(
                    height: 8,
                    decoration: const BoxDecoration(
                      color: CustomColor.gray05
                    ),
                  ),
                  Padding(
                    key: sectionKey3,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16,),
                        Text(
                          '고객지원',
                          style: CustomText.body10.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              direction: Axis.vertical,
                              spacing: 8.0,
                              children: [
                                InkWell(
                                  onTap: () {
                                
                                  },
                                  child: const Text(
                                    '공지사항',
                                    style: CustomText.body10
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                
                                  },
                                  child: const Text(
                                    '약관 및 정책',
                                    style: CustomText.body10
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(ProjectConstant.PUPPYPOO_WEB_URL));
                                  },
                                  child: const Text(
                                    '고객센터',
                                    style: CustomText.body10
                                  ),
                                ),
                              ],
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              spacing: 8.0,
                              children: [
                                InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(ProjectConstant.PUPPYPOO_KAKAO_URL));
                                  },
                                  child: const Text(
                                    '카카오채널',
                                    style: CustomText.body10
                                  ),
                                ),
                              ],
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              spacing: 8.0,
                              children: [
                                InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(ProjectConstant.PUPPYPOO_INSTAGRAM_URL));
                                  },
                                  child: const Text(
                                    '인스타그램',
                                    style: CustomText.body10
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16,),
                      ],
                    ),
                  ),
                  Container(
                    width: kIsWeb ? ProjectConstant.WEB_MAX_WIDTH : MediaQuery.of(context).size.width,
                    height: companySectionHeight > 400 ? companySectionHeight : 400,
                    decoration: const BoxDecoration(
                      color: CustomColor.gray05
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16,),
                          Text(
                            '(주)도터펫',
                            style: CustomText.body10.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16,),
                          const Text(
                            '대표자 : 강희원',
                            style: CustomText.body10
                          ),
                          const SizedBox(height: 8,),
                          const Text(
                            '주소 : 부산광역시 동구 중앙대로 319 YMCA 9층 L10호',
                            style: CustomText.body10
                          ),
                          const SizedBox(height: 8,),
                          const Text(
                            '사업자번호 : 314-86-68368',
                            style: CustomText.body10
                          ),
                          const SizedBox(height: 8,),
                          const Text(
                            '고객센터 : pupoo2023@gmail.com',
                            style: CustomText.body10
                          ),
                          const SizedBox(height: 8,),
                          const Text(
                            '운영시간 : 평일 오전 9시~오후 5시 (점심시간 오후 1시~2시)',
                            style: CustomText.body10
                          ),
                          const SizedBox(height: 32,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}