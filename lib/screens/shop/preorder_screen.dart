import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/screens/shop/widget/preorder/0001/0001.dart';
import 'package:url_launcher/url_launcher.dart';

class PreorderScreen extends ConsumerStatefulWidget {
  const PreorderScreen({super.key});

  @override
  ConsumerState<PreorderScreen> createState() => PreorderScreenState();
}

class PreorderScreenState extends ConsumerState<PreorderScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '사전예약 안내',
        leadingOnPressed: () {
          if(!context.mounted) return;
          context.pop();
        },
        actionDisable: true,
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
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: fnGetDeviceWidth(context),
                      constraints: const BoxConstraints(
                        maxHeight: 167,
                      ),
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 3/1,
                            child: Image.asset(
                              'assets/icons/preorder/0001/banner01.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          AspectRatio(
                            aspectRatio: 3/1,
                            child: Container(
                              padding: const EdgeInsets.only(left: 32),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '포프린트 PawPrint',
                                    style: CustomText.body7.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8,),
                                  Text(
                                    '사전예약 혜택',
                                    style: CustomText.body7.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: fnGetDeviceWidth(context),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 32,),
                          Text(
                            '이런 분들께 추천드려요',
                            style: CustomText.body7,
                          ),
                          SizedBox(height: 32,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PreorderRecommandContainer(
                                text: '소화질환 경험이 있는\n반려동물을 키우는 사람'
                              ),
                              PreorderRecommandContainer(
                                text: '하루 4시간 이상\n집을 비우는 사람'
                              ),
                              PreorderRecommandContainer(
                                text: '밥을 가려 먹는\n반려동물을 키우는 사람'
                              ),
                            ],
                          ),
                          SizedBox(height: 32,),
                        ],
                      ),
                    ),
                    Container(
                      width: fnGetDeviceWidth(context),
                      constraints: const BoxConstraints(
                        maxHeight: 656,
                      ),
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.5/1,
                            child: Image.asset(
                              'assets/icons/preorder/0001/banner02.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          AspectRatio(
                            aspectRatio: 1.5/1,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 32,),
                                  Text(
                                    '감으로만 건강관리를 했던 나,',
                                    style: CustomText.body7.copyWith(
                                      fontSize: fnGetDeviceWidth(context) > 400 ? 20 : 18,
                                      color: CustomColor.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '이제 포프린트로 케어해보세요.',
                                    style: CustomText.body7.copyWith(
                                      fontSize: fnGetDeviceWidth(context) > 400 ? 20 : 18,
                                      color: CustomColor.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8,),
                                  Text(
                                    '예약 마감까지',
                                    style: CustomText.body9.copyWith(
                                      fontSize: fnGetDeviceWidth(context) > 400 ? 16 : 14,
                                      color: CustomColor.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // SizedBox(
                                  //   height: fnGetDeviceWidth(context) >= 500 ? 100 : 80,
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //     children: [
                                  //       Column(
                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             '24',
                                  //             style: CustomText.heading1.copyWith(
                                  //               fontSize: fnGetDeviceWidth(context) > 400 ? 32 : 20,
                                  //               color: CustomColor.white,
                                  //             ),
                                  //           ),
                                  //           const SizedBox(height: 4,),
                                  //           Text(
                                  //             '일',
                                  //             style: CustomText.body7.copyWith(
                                  //               fontSize: fnGetDeviceWidth(context) > 400 ? 20 : 18,
                                  //               color: CustomColor.white,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       Container(
                                  //         width: 1,
                                  //         margin: const EdgeInsets.symmetric(horizontal: 4),
                                  //         decoration: const BoxDecoration(
                                  //           color: CustomColor.white,
                                  //         ),
                                  //       ),
                                  //       Column(
                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             '07',
                                  //             style: CustomText.heading1.copyWith(
                                  //               fontSize: fnGetDeviceWidth(context) > 400 ? 32 : 20,
                                  //               color: CustomColor.white,
                                  //             ),
                                  //           ),
                                  //           const SizedBox(height: 4,),
                                  //           Text(
                                  //             '시',
                                  //             style: CustomText.body7.copyWith(
                                  //               fontSize: fnGetDeviceWidth(context) > 400 ? 20 : 18,
                                  //               color: CustomColor.white,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       Container(
                                  //         width: 1,
                                  //         margin: const EdgeInsets.symmetric(horizontal: 4),
                                  //         decoration: const BoxDecoration(
                                  //           color: CustomColor.white,
                                  //         ),
                                  //       ),
                                  //       Column(
                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             '46',
                                  //             style: CustomText.heading1.copyWith(
                                  //               fontSize: fnGetDeviceWidth(context) > 400 ? 32 : 20,
                                  //               color: CustomColor.white,
                                  //             ),
                                  //           ),
                                  //           const SizedBox(height: 4,),
                                  //           Text(
                                  //             '분',
                                  //             style: CustomText.body7.copyWith(
                                  //               fontSize: fnGetDeviceWidth(context) > 400 ? 20 : 18,
                                  //               color: CustomColor.white,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       Container(
                                  //         width: 1,
                                  //         margin: const EdgeInsets.symmetric(horizontal: 4),
                                  //         decoration: const BoxDecoration(
                                  //           color: CustomColor.white,
                                  //         ),
                                  //       ),
                                  //       Column(
                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             '03',
                                  //             style: CustomText.heading1.copyWith(
                                  //               fontSize: fnGetDeviceWidth(context) > 400 ? 32 : 20,
                                  //               color: CustomColor.white,
                                  //             ),
                                  //           ),
                                  //           const SizedBox(height: 4,),
                                  //           Text(
                                  //             '초',
                                  //             style: CustomText.body7.copyWith(
                                  //               fontSize: fnGetDeviceWidth(context) > 400 ? 20 : 18,
                                  //               color: CustomColor.white,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  const PreorderCountdownTimerContainer(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: fnGetDeviceWidth(context),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 32,),
                          Text(
                            '서비스 구성',
                            style: CustomText.body7.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            'assets/icons/preorder/0001/puppy_tracker.png',
                            width: fnGetDeviceWidth(context) / 2.5,
                            height: fnGetDeviceWidth(context) / 2.5,
                          ),
                          Text(
                            '반려동물 유기율을 줄이고자 하는게 PawPrint의 목표',
                            style: CustomText.body7.copyWith(
                              fontSize: fnGetDeviceWidth(context) > 400 ? 20 : 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16,),
                          const Text(
                            '''
              스페인에서는 유기율을 줄이기 위해 건강 및 위치를 확인할 수 있는 디바이스를 반려동물에게 부착하는 법안을 통과시켰고, 약 11% 이상의 유기율 감소를 실천했습니다.
              
              미국 뿐만 아니라 한국의 농림축산식품에서도 이런 실험에 공감하듯, 반려동물과의 유대감을 높일 수 있는 다양한 연구를 진행하고 있고 도터펫팀은 이런 실천의 첫 단추로 ‘포프린트'를 개발하게 되었습니다.
              ''',
                            style: CustomText.caption2,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 64,),
                          Text(
                            '포프린트 디바이스로 무엇을 할 수 있을까?',
                            style: CustomText.body7.copyWith(
                              fontSize: fnGetDeviceWidth(context) > 400 ? 20 : 18,
                            ),
                          ),
                          const SizedBox(height: 32,),
                          Text(
                            '생체리듬 분석',
                            style: CustomText.body9.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 32,),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PreorderAppFeatureContainer(
                                img: '0001/sleep.png', 
                                text: '수면 분석'
                              ),
                              PreorderAppFeatureContainer(
                                img: '0001/activity.png', 
                                text: '활동량 분석'
                              ),
                              PreorderAppFeatureContainer(
                                img: '0001/clock.png', 
                                text: '24시간 추적'
                              ),
                              PreorderAppFeatureContainer(
                                img: '0001/report.png', 
                                text: '월간 보고서'
                              ),
                            ],
                          ),
                          const SizedBox(height: 32,),
                          Text(
                            '사료적합성 분석',
                            style: CustomText.body9.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 32,),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PreorderAppFeatureContainer(
                                img: '0001/pattern.png', 
                                text: '활동 패턴 분석'
                              ),
                              PreorderAppFeatureContainer(
                                img: '0001/poop.png', 
                                text: '변 건강 고려'
                              ),
                              PreorderAppFeatureContainer(
                                img: '0001/feed.png', 
                                text: '영양 사료 추천'
                              ),
                            ],
                          ),
                          const SizedBox(height: 32,),
                          Text(
                            '반려동물의 디지털트윈 키우기',
                            style: CustomText.body9.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 32,),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PreorderAppFeatureContainer(
                                img: '0001/digital_twin.png', 
                                text: '우리 아이\n디지털쌍둥이'
                              ),
                              PreorderAppFeatureContainer(
                                img: '0001/health.png', 
                                text: '움직임이\n건강이 돼요'
                              ),
                              PreorderAppFeatureContainer(
                                img: '0001/data.png', 
                                text: '데이터로\n돌봄이 쉬워요'
                              ),
                              PreorderAppFeatureContainer(
                                img: '0001/mission.png', 
                                text: '하루 미션으로\n건강 UP'
                              ),
                            ],
                          ),
                          const SizedBox(height: 32,),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1/1.5,
                          child: Image.asset(
                            'assets/icons/preorder/0001/banner03.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 1/1.5,
                          child: Container(
                            width: fnGetDeviceWidth(context),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: const BoxDecoration(
                              // color: CustomColor.gray05,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 32,),
                                Text(
                                  '사전예약 혜택',
                                  style: CustomText.body7.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 32,),
                                SizedBox(
                                  width: fnGetDeviceWidth(context),
                                  child: const SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        PreorderBenefitContainer(
                                          img: '0001/card1.png', 
                                          title: '사회유기예방증 증정', 
                                          text: '유기율을 절감시켜주는 사회적\n움직임의 첫 걸음을 기념하는 증서'
                                        ),
                                        PreorderBenefitContainer(
                                          img: '0001/card2.png', 
                                          title: '하트 코인 충전', 
                                          text: '영양사료 할인쿠폰 또는 디지털트윈이용\n옷, 침대, 장신구 등으로 교환할 수 있어요!'
                                        ),
                                        PreorderBenefitContainer(
                                          img: '0001/card3.png', 
                                          title: '영양 사료 할인 쿠폰', 
                                          text: '건강 상태를 분석해\n기존 사료에 영양제를 배합해드려요 :)'
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32,),
                                SizedBox(
                                  width: fnGetDeviceWidth(context),
                                  child: const SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        PreorderBenefitContainer(
                                          img: '0001/card4.png', 
                                          title: '얼리어답터 토큰', 
                                          text: '포프린트의 역사적인 첫 시작을 함께하는\n여러분들께만 드리는 리미티드 토큰'
                                        ),
                                        PreorderBenefitContainer(
                                          img: '0001/card5.png', 
                                          title: '영양 사료 정기 구독 혜택', 
                                          text: '같은 사료 가격, 다른 맞춤 사료 케어 서비스\n영양 사료 첫 달 70% 할인'
                                        ),
                                        PreorderBenefitContainer(
                                          img: '0001/card6.png', 
                                          title: '월간 건강 레포트 전송', 
                                          text: '활동량 + 수면량 + 변 상태 분석 후,\n다른 반려동물과의 건강 비교 분석 레포트'
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 64,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 32,),
                  ],
                )
              ),

              Positioned(
                bottom: 50,
                left: 16,
                right: 16,
                child: DefaultIconButton(
                  disabled: false,
                  onPressed: () {
                    // TODO : 사전 예약 링크 이동 - 임시로 문의하기 링크 연동 2025.07.06
                    launchUrl(Uri.parse(ProjectConstant.INQUIRY_URL));
                  }, 
                  text: '사전 예약하기',
                  height: 42,
                  borderRadius: 16,
                  backgroundColor: CustomColor.yellow03,
                  borderColor: CustomColor.yellow03,
                  textColor: const Color.fromARGB(255, 28, 22, 22),
                  elevation: 4,
                  svgPicture: SvgPicture.asset(
                    'assets/icons/etc/cursor_click.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
