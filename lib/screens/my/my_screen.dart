import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
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
  GlobalKey sectionKey4 = GlobalKey();

  double companySectionHeight = 400;  // 초기값 꼭 선언 필요

  @override
  void initState() {
    super.initState();
    fnInitMyController(ref, context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        companySectionHeight = MediaQuery.of(context).size.height
            - fnGetSize(sectionKey1).height
            - fnGetSize(sectionKey2).height
            - fnGetSize(sectionKey3).height
            - fnGetSize(sectionKey4).height
            - 32 // 중간 공백 등
            - 50 // 앱바
            - 50; // 네비게이션바
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final responseUserMypageState = ref.watch(responseUserMypageProvider);
    final responseDogsState = ref.watch(responseDogsProvider);
    final homeActivatedPetNavState = ref.watch(homeActivatedPetNavProvider);

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
          ref.read(bottomNavProvider.notifier).set(0);
          context.goNamed('home_screen');
          return;
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
                                  responseUserMypageState.email != ""
                                      ? responseUserMypageState.email
                                      : "example@pawprint.ai.kr",
                                  style: CustomText.body10,
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
                    decoration: const BoxDecoration(color: CustomColor.gray05),
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
                        for (int i = 0; i < responseDogsState.length; i++)
                          Column(
                            children: [
                              DefaultTextButton(
                                text: responseDogsState[i].pet_name,
                                borderColor: homeActivatedPetNavState == i
                                    ? CustomColor.yellow03
                                    : CustomColor.gray04,
                                backgroundColor: homeActivatedPetNavState == i
                                    ? CustomColor.yellow03
                                    : CustomColor.white,
                                disabled: false,
                                height: 40,
                                onPressed: () {
                                  fnInitMyPetUpdateState(responseDogsState[i]);
                                  context.goNamed(
                                    'my_pet_update_screen',
                                    queryParameters: {'pet_id': responseDogsState[i].pet_id.toString()},
                                  );
                                },
                              ),
                              const SizedBox(height: 16,),
                            ],
                          ),
                        DefaultTextButton(
                          text: '+',
                          borderColor: CustomColor.gray04,
                          backgroundColor: responseDogsState.length >= 3
                              ? CustomColor.gray04
                              : CustomColor.white,
                          disabled: false,
                          height: 40,
                          onPressed: () {
                            if (responseDogsState.length >= 3) {
                              showAlertDialog(
                                  context: context,
                                  middleText: "반려동물은 최대 3마리까지 추가할 수 있습니다.");
                              return;
                            }
                            fnInitMyPetAddState();
                            context.goNamed('my_pet_add_screen');
                          },
                        ),
                        const SizedBox(height: 16,),
                      ],
                    ),
                  ),
                  // ########## Fitbark 연동하기 ##########
                  Container(
                    height: 8,
                    decoration: const BoxDecoration(color: CustomColor.gray05),
                  ),
                  Padding(
                    key: sectionKey3,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16,),
                        Text(
                          'Fitbark GPS 기기 연동하기',
                          style: CustomText.body10.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        DefaultTextButton(
                          text: 'FitBark 연동하기',
                          borderColor: responseDogsState.isEmpty 
                              ? CustomColor.gray04
                              : const Color(0xFF009bb3),
                          backgroundColor: responseDogsState.isEmpty
                              ? CustomColor.gray04
                              : const Color(0xFF009bb3),
                          textColor: responseDogsState.isEmpty
                              ? CustomColor.gray03
                              : CustomColor.white,
                          disabled: false,
                          onPressed: () async {
                            if(responseDogsState.isEmpty) {
                              showAlertDialog(
                                context: context, 
                                middleText: '반려동물을 먼저 등록해주세요!'
                              );
                              return;
                            } else {
                              // await fnCallFitBarkApp();
                              // kIsWeb ?
                              //   context.goNamed('my_fitbark_web_screen') :
                              //   context.goNamed('my_fitbark_screen');
                            }

                            if(kIsWeb) {
                              showAlertDialog(
                                context: context, 
                                middleText: '포프린트 앱에서 Fitbark GPS 기기 연동이 가능합니다.'
                              );
                              return;
                            } 

                            if(responseDogsState[homeActivatedPetNavState].pet_device_connected) {
                              showAlertDialog(
                                context: context, 
                                middleText: '이미 Fitbark GPS 기기 연동이 완료된 반려동물입니다.'
                              );
                              return;
                            } else {
                              showConfirmDialog(
                                context: context, 
                                middleText: "현재 활성화된 반려동물은 ${responseDogsState[homeActivatedPetNavState].pet_name} 입니다.\n기기 연동을 진행하시겠습니까?", 
                                onConfirm: () {
                                  context.goNamed('my_fitbark_screen');
                                }
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 16,),
                      ],
                    ),
                  ),
                  Container(
                    height: 8,
                    decoration: const BoxDecoration(color: CustomColor.gray05),
                  ),
                  Padding(
                    key: sectionKey4,
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
                                    launchUrl(Uri.parse(ProjectConstant.NOTICE_URL));
                                  },
                                  child: const Text(
                                    '공지사항',
                                    style: CustomText.body10,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(ProjectConstant.TERMS_OF_USER));
                                  },
                                  child: const Text(
                                    '약관 및 정책',
                                    style: CustomText.body10,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(ProjectConstant.PUPPYPOO_WEB_URL));
                                  },
                                  child: const Text(
                                    '고객센터',
                                    style: CustomText.body10,
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     launchUrl(Uri.parse(ProjectConstant.PRIVACY_POLICY));
                                //   },
                                //   child: const Text(
                                //     '개인정보처리방침',
                                //     style: CustomText.body10
                                //   ),
                                // ),
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
                                    style: CustomText.body10,
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
                                    style: CustomText.body10,
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
                    decoration: const BoxDecoration(color: CustomColor.gray05),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16,),
                          Text(
                            '(주)도터펫',
                            style: CustomText.body10,
                          ),
                          SizedBox(height: 16,),
                          Text(
                            '대표자 : 강희원',
                            style: CustomText.body10,
                          ),
                          SizedBox(height: 8,),
                          Text(
                            '주소 : 부산광역시 동구 중앙대로 319 YMCA 9층 L10호',
                            style: CustomText.body10,
                          ),
                          SizedBox(height: 8,),
                          Text(
                            '사업자번호 : 314-86-68368',
                            style: CustomText.body10,
                          ),
                          SizedBox(height: 8,),
                          Text(
                            '고객센터 : pupoo2023@gmail.com',
                            style: CustomText.body10,
                          ),
                          SizedBox(height: 8,),
                          Text(
                            '운영시간 : 평일 오전 9시~오후 5시 (점심시간 오후 1시~2시)',
                            style: CustomText.body10,
                          ),
                          SizedBox(height: 32,),
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
