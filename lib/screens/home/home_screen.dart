import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
import 'package:petbuddy_frontend_flutter/controller/home_controller.dart';
import 'package:petbuddy_frontend_flutter/controller/my_controller.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:petbuddy_frontend_flutter/data/provider/response_poo_monthly_mean_provider.dart';
import 'package:petbuddy_frontend_flutter/screens/home/widget/widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> with HomeController, MyController {
  bool _isInitialOnPageChanged = true;

  @override
  void initState() {
    super.initState();
    fnInitHomeController(ref, context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // homeScreenPetController = PageController(initialPage: ref.read(homeActivatedPetNavProvider.notifier).get());      

      final homeActivatedPetNav = ref.read(homeActivatedPetNavProvider.notifier).get();
      final responseDogs = ref.read(responseDogsProvider.notifier).get();
      
      // if (ref.read(responseDogsProvider.notifier).get().length > 1) {
      if (responseDogs.length > 1) {
        // homeScreenPetController.jumpToPage(ref.read(homeActivatedPetNavProvider.notifier).get());
        homeScreenPetController.jumpToPage(homeActivatedPetNav);

        // ========== 반려동물 조회 ==========
        // 반려동물 한달평균 건강점수
        fnPooMonthlyMeanExec(DateFormat("yyyy-MM").format(DateTime.now()), responseDogs[homeActivatedPetNav].pet_id);

        // 해당 월 세팅
        ref.read(homePoopReportMonthSelectProvider.notifier).set(int.parse(DateFormat("MM").format(DateTime.now()).toString()));
        ref.read(homePoopReportPreviousMonthSelectProvider.notifier).set(int.parse(DateFormat("MM").format(DateTime.now()).toString()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeActivatedPetNavState = ref.watch(homeActivatedPetNavProvider);
    final responseDogsState = ref.watch(responseDogsProvider);
    final storage = ref.watch(secureStorageProvider);
    final responsePooMonthlyMeanState = ref.watch(responsePooMonthlyMeanProvider);

    // 라우터 이동
    final extra = GoRouter.of(context).routerDelegate.currentConfiguration.extra;
    final shouldGo = extra is Map && extra['should_go'] == true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (shouldGo) {
        context.goNamed(extra['screen_name']);
      }
    });

    return DefaultLayout(
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
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 300,),
                    AspectRatio(
                      aspectRatio: 1/2.5,
                      child: Image.asset(
                        'assets/icons/etc/home_background.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16,),
                      Text(
                        responseDogsState.isNotEmpty ? 
                          '${responseDogsState[homeActivatedPetNavState].pet_name}, 반가워요!' :
                          '반가워요!',
                        style: CustomText.heading1.copyWith(
                          color: CustomColor.blue03,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/etc/heart.svg',
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 8,),
                          Text(
                            '하트코인(준비 중)',
                            style: CustomText.body10.copyWith(
                              color: CustomColor.gray03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16,),
                          Text(
                            NumberFormat('###,###,###,###').format(1350),
                            style: CustomText.body10.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      responseDogsState.isNotEmpty ? 
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 52,
                          child: const SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // TODO : loop로 데이터 받아 출력
                                HomeCardMissionContainer(
                                  imoji: '🐕',
                                  title: '산책하기', 
                                  text: '4시간 뒤 소멸'
                                ),
                                HomeCardMissionContainer(
                                  imoji: '🍖',
                                  title: '맘마주기', 
                                  text: '1시간 뒤 소멸'
                                ),
                                HomeCardMissionContainer(
                                  imoji: '💩',
                                  title: '똥 찍기', 
                                  text: '2시간 뒤 소멸'
                                ),
                                HomeCardMissionContainer(
                                  imoji: '😴',
                                  title: '낮잠재우기', 
                                  text: '2시간 뒤 소멸'
                                ),
                              ],
                            ),
                          ),
                        ) :
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 52,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ref.read(bottomNavProvider.notifier).set(3);
                                    context.goNamed('my_screen');
                                  },
                                  child: const HomeCardMissionContainer(
                                    imoji: '💤',
                                    title: '강아지 등록해 잠깨우기', 
                                    text: '반려동물을 등록해보세요:)',
                                    maxWidth: 200,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 16,),
                      responseDogsState.isEmpty ?
                        SizedBox(
                          width: fnGetDeviceWidth(context),
                          height: fnGetDeviceWidth(context),
                          child: PageView(
                            controller: homeScreenPetController,
                            padEnds: false,
                            onPageChanged: (index) {
                              ref.read(homeActivatedPetNavProvider.notifier).set(index);
                            },
                            children: [
                              HomeCardPetContainer(
                                onPressed: () {
                                  
                                },
                                petImg: Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: fnGetDeviceWidth(context) * 0.1,
                                  child: Image.asset(
                                    'assets/icons/illustration/puppy_null.png',
                                    width: fnGetDeviceWidth(context) * 0.5,
                                    height: fnGetDeviceWidth(context) * 0.5,
                                  ),
                                ),
                              ), 
                            ],
                          ),
                        ) :
                        SizedBox(
                          width: fnGetDeviceWidth(context),
                          height: fnGetDeviceWidth(context),
                          child: PageView(
                            controller: homeScreenPetController,
                            padEnds: false,
                            onPageChanged: (index) async {
                              if (_isInitialOnPageChanged && homeActivatedPetNavState == index) {
                                _isInitialOnPageChanged = false;
                                return;
                              }

                              ref.read(homeActivatedPetNavProvider.notifier).set(index);
                              // 반려동물 활성화 알림 토스트 메시지
                              textToast(
                                context, 
                                "${responseDogsState[index].pet_name}을(를) 보고 있어요!",
                                bottom: 0,
                              );
                              // 로그인 시 반려동물 활성화 인덱스 불러오기 위해 저장
                              await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: index.toString());
                              // 강아지 스와이프 시 해당월 변 데이터 조회
                              // 반려동물 해당월 변 데이터 조회
                              fnPooMonthlyMeanExec(DateFormat("yyyy-MM").format(DateTime.now()), responseDogsState[index].pet_id);
                              // 해당 월 세팅
                              // ref.read(homePoopReportMonthSelectProvider.notifier).set(int.parse(DateFormat("MM").format(DateTime.now()).toString()));
                              // ref.read(homePoopReportPreviousMonthSelectProvider.notifier).set(int.parse(DateFormat("MM").format(DateTime.now()).toString()));
                            },
                            children: [
                                for(int i=0;i<responseDogsState.length;i++)
                                  HomeCardPetContainer(
                                    onPressed: () { 
                                      
                                    },
                                    petImg: Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: fnGetDeviceWidth(context) * 0.2,
                                      child: SvgPicture.asset( // 강아지 일러스트 변하지 않도록 pet_id 별로 고정된 일러스트 보여줌
                                        'assets/icons/illustration/puppy_${
                                          fnGetPetTypesIndexByCode(responseDogsState[i].division2_code) % 3 == 0 ? 
                                            'white' : 
                                            fnGetPetTypesIndexByCode(responseDogsState[i].division2_code) % 3 == 1 ? 
                                              'yellow' : 'black'
                                        }.svg',
                                        width: fnGetDeviceWidth(context) * 0.3,
                                        height: fnGetDeviceWidth(context) * 0.35,
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // 등록된 반려동물 마리수 가져오기
                        children: List.generate(responseDogsState.length, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: homeActivatedPetNavState == index ? 12 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(Radius.circular(6),),
                              color: homeActivatedPetNavState == index || responseDogsState.length <= 1
                                  ? const Color(0xFFF6D72E)
                                  : const Color(0xFFE8E8E8),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HomeCardManageContainer(
                            title: "걸음 수", 
                            thumbnailPicture: SvgPicture.asset(
                              'assets/icons/etc/paw.svg',
                              width: 24,
                              height: 24,
                            ),
                            onPressed: () {
                              context.goNamed("home_activity_report_screen");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  NumberFormat('###,###,###,###').format(23245),
                                  style: CustomText.body4.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColor.blue03,
                                  ),
                                ),
                                const SizedBox(width: 8,),
                                Text(
                                  '걸음',
                                  style: CustomText.caption2.copyWith(
                                    color: CustomColor.gray02,
                                  ),
                                )
                              ],
                            ),
                          ),
                          HomeCardManageContainer(
                            title: "똥 건강", 
                            thumbnailPicture: SvgPicture.asset(
                              'assets/icons/etc/poop.svg',
                              width: 24,
                              height: 24,
                            ),
                            onPressed: () {
                              if(responseDogsState.isEmpty) {
                                showAlertDialog(
                                  context: context, 
                                  middleText: "반려동물을 먼저 등록해주세요!",
                                  onConfirm: () {
                                    ref.read(bottomNavProvider.notifier).set(3);
                                    context.goNamed('my_screen');
                                  }
                                );
                              } else {
                                context.goNamed("home_poop_report_screen");
                              }
                            },
                            child: Container(
                              height: 45,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.all(Radius.circular(32),),
                              ),
                              child: LayoutBuilder(builder: (context, contraints) {
                                return Row(
                                  children: [
                                    Container(
                                      width: contraints.maxWidth / 3,
                                      height: contraints.maxHeight,
                                      decoration: BoxDecoration(
                                        color: responseDogsState.isNotEmpty && responsePooMonthlyMeanState.monthly_poop_list.isNotEmpty && (responsePooMonthlyMeanState.poop_score_total ?? 0) < 50 ? 
                                          CustomColor.yellow03 :
                                          const Color(0xFFF5F5F5),
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), bottomLeft: Radius.circular(32),),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '양호',
                                          style: CustomText.caption3.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: contraints.maxWidth / 3,
                                      height: contraints.maxHeight,
                                      decoration: BoxDecoration(
                                        color:  responseDogsState.isNotEmpty && responsePooMonthlyMeanState.monthly_poop_list.isNotEmpty && (responsePooMonthlyMeanState.poop_score_total ?? 0) >= 50 && (responsePooMonthlyMeanState.poop_score_total ?? 0) < 70 ? 
                                          CustomColor.yellow03 :
                                          const Color(0xFFF5F5F5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '주의',
                                          style: CustomText.caption3.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: contraints.maxWidth / 3,
                                      height: contraints.maxHeight,
                                      decoration: BoxDecoration(
                                        color:  responseDogsState.isNotEmpty && responsePooMonthlyMeanState.monthly_poop_list.isNotEmpty && (responsePooMonthlyMeanState.poop_score_total ?? 0) > 70 ? 
                                          CustomColor.yellow03 :
                                          const Color(0xFFF5F5F5),
                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(32), bottomRight: Radius.circular(32),),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '위험',
                                          style: CustomText.caption3.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HomeCardManageContainer(
                            disabled: true,
                            thumbnailPicture: SvgPicture.asset(
                              'assets/icons/etc/sleep.svg',
                              width: 24,
                              height: 24,
                            ),
                            title: "수면 효율",
                            onPressed: () {
                              showAlertDialog(
                                context: context, 
                                middleText: Sentence.UPDATE_ALERT,
                                onConfirm: () {
                                  // 사전예약 페이지 이동
                                  context.pushNamed('preorder_screen');
                                }
                              );

                              // TODO : 수면 효율 페이지 이동
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '55',
                                  style: CustomText.body4.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColor.blue03,
                                  ),
                                ),
                                const SizedBox(width: 8,),
                                Text(
                                  '%',
                                  style: CustomText.caption2.copyWith(
                                    color: CustomColor.gray02,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          HomeCardManageContainer(
                            title: "곳간", 
                            thumbnailPicture: SvgPicture.asset(
                              'assets/icons/etc/feed.svg',
                              width: 24,
                              height: 24,
                            ),
                            onPressed: () {
                              context.goNamed("home_feed_report_screen");
                            },
                            child: LayoutBuilder(builder: (context, constraints) {
                              return Stack(
                                children: [
                                  Container(
                                    width: constraints.maxWidth,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.all(Radius.circular(32),),
                                    ),
                                  ),
                                  Container(
                                    width: constraints.maxWidth * 0.6,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      color: CustomColor.yellow03,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(32), bottomLeft: Radius.circular(32)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth,
                                    height: 45,
                                    child: Center(
                                      child: Text(
                                        '20일 정도 먹을 수 있어요!',
                                        style: CustomText.caption3.copyWith(
                                          color: CustomColor.gray02,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      HomeCardReportLayoutContainer(
                        thumbnailPicture: SvgPicture.asset(
                          'assets/icons/etc/today_report.svg',
                          width: 20,
                          height: 20,
                        ),
                        subTitle: '탄이는 다음 3가지 관리가 필요해요!',
                        reportList: [
                          HomeCardReportModel(
                            title: '#활동량', 
                            content: Sentence.UPDATE_ALERT, // '아침, 저녁 산책을 권장드려요!',
                            svgPicture: SvgPicture.asset(
                              'assets/icons/etc/paw.svg',
                              width: 64,
                              height: 64,
                            ),
                          ),
                          HomeCardReportModel(
                            title: '#수면', 
                            content: Sentence.UPDATE_ALERT, // '30분 낮잠이 필요한 것 같아요',
                            svgPicture: SvgPicture.asset(
                              'assets/icons/etc/sleep.svg',
                              width: 64,
                              height: 64,
                            ),
                          ),
                          HomeCardReportModel(
                            title: '#규칙적인 습관', 
                            content: Sentence.UPDATE_ALERT, // '간식은 정해진 시간에 챙겨줘야 해요',
                            svgPicture: SvgPicture.asset(
                              'assets/icons/etc/feed.svg',
                              width: 64,
                              height: 64,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
