import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';

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
          // await fnClose(context);
        },
        child: SafeArea(
          child: SingleChildScrollView(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32,),
                      const Text(
                        '이런 분들께 추천드려요',
                        style: CustomText.body7,
                      ),
                      const SizedBox(height: 32,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: fnGetDeviceWidth(context) / 4,
                                height: fnGetDeviceWidth(context) / 4,
                                decoration: const BoxDecoration(
                                  color: CustomColor.gray04,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '소화질환 경험이 있는\n반려동물을 키우는 사람',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: fnGetDeviceWidth(context) / 4,
                                height: fnGetDeviceWidth(context) / 4,
                                decoration: const BoxDecoration(
                                  color: CustomColor.gray04,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '하루 4시간 이상\n집을 비우는 사람',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: fnGetDeviceWidth(context) / 4,
                                height: fnGetDeviceWidth(context) / 4,
                                decoration: const BoxDecoration(
                                  color: CustomColor.gray04,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '밥을 가려 먹는\n반려동물을 키우는 사람',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32,),
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
                                  color: CustomColor.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Text(
                                '이제 포프린트로 케어해보세요.',
                                style: CustomText.body7.copyWith(
                                  color: CustomColor.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16,),
                              Text(
                                '예약 마감까지',
                                style: CustomText.body9.copyWith(
                                  color: CustomColor.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16,),
                              SizedBox(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '24',
                                          style: CustomText.heading1.copyWith(
                                            color: CustomColor.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4,),
                                        Text(
                                          '일',
                                          style: CustomText.body7.copyWith(
                                            color: CustomColor.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 1,
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      decoration: const BoxDecoration(
                                        color: CustomColor.white,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '07',
                                          style: CustomText.heading1.copyWith(
                                            color: CustomColor.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4,),
                                        Text(
                                          '시',
                                          style: CustomText.body7.copyWith(
                                            color: CustomColor.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 1,
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      decoration: const BoxDecoration(
                                        color: CustomColor.white,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '46',
                                          style: CustomText.heading1.copyWith(
                                            color: CustomColor.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4,),
                                        Text(
                                          '분',
                                          style: CustomText.body7.copyWith(
                                            color: CustomColor.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 1,
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      decoration: const BoxDecoration(
                                        color: CustomColor.white,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '03',
                                          style: CustomText.heading1.copyWith(
                                            color: CustomColor.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4,),
                                        Text(
                                          '초',
                                          style: CustomText.body7.copyWith(
                                            color: CustomColor.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                        width: fnGetDeviceWidth(context) / 3,
                        height: fnGetDeviceWidth(context) / 3,
                      ),
                      const Text(
                        '반려동물 유기율을 줄이고자 하는게 PawPrint의 목표',
                        style: CustomText.body7,
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
                      const Text(
                        '포프린트 디바이스로 무엇을 할 수 있을까?',
                        style: CustomText.body7,
                      ),
                      const SizedBox(height: 32,),
                      Text(
                        '생체리듬 분석',
                        style: CustomText.body9.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/preorder/0001/sleep.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '수면 분석',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/preorder/0001/activity.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '활동량 분석',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/preorder/0001/clock.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '24시간 추적',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/preorder/0001/report.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '월간 보고서',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/preorder/0001/pattern.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '활동 패턴 분석',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/preorder/0001/poop.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '변 건강 고려',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/preorder/0001/feed.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '영양 사료 추천',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/preorder/0001/digital_twin.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '우리 아이\n디지털쌍둥이',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/preorder/0001/health.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '움직임이\n건강이 돼요',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/preorder/0001/data.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '데이터로\n돌봄이 쉬워요',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/icons/preorder/0001/mission.png',
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                '하루 미션으로\n건강 UP',
                                style: CustomText.caption3,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32,),
                    ],
                  ),
                ),
                Container(
                  width: fnGetDeviceWidth(context),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    color: CustomColor.gray05,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 32,),
                      Text(
                        '사전예약 해텍',
                        style: CustomText.body7.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32,),
                      SizedBox(
                        width: fnGetDeviceWidth(context),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                width: fnGetDeviceWidth(context) / 3 + 96,
                                height: fnGetDeviceWidth(context) / 3,
                                decoration: const BoxDecoration(
                                  color: CustomColor.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                margin: const EdgeInsets.only(right: 16),
                                child: Column(
                                  children: [
                                    Container(
                                      width: fnGetDeviceWidth(context) / 3 + 96,
                                      height: fnGetDeviceWidth(context) / 6,
                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                      child: Image.asset(
                                        'assets/icons/preorder/0001/certificate.png',
                                      ),
                                    ),
                                    Container(
                                      width: fnGetDeviceWidth(context) / 3 + 96,
                                      height: fnGetDeviceWidth(context) / 6,
                                      decoration: const BoxDecoration(
                                        color: CustomColor.gray03,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '사회유기예방증 증정',
                                            style: CustomText.body10.copyWith(
                                              color: CustomColor.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4,),
                                          Text(
                                            '유기율을 절감시켜주는 사회적\n움직임의 첫 걸음을 기념하는 증서',
                                            style: CustomText.caption3.copyWith(
                                              color: CustomColor.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: fnGetDeviceWidth(context) / 3 + 96,
                                height: fnGetDeviceWidth(context) / 3,
                                decoration: const BoxDecoration(
                                  color: CustomColor.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                margin: const EdgeInsets.only(right: 16),
                                child: Column(
                                  children: [
                                    Container(
                                      width: fnGetDeviceWidth(context) / 3 + 96,
                                      height: fnGetDeviceWidth(context) / 6,
                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                      /* child: Image.asset(
                                        'assets/icons/preorder/0001/certificate.png',
                                      ), */
                                    ),
                                    Container(
                                      width: fnGetDeviceWidth(context) / 3 + 96,
                                      height: fnGetDeviceWidth(context) / 6,
                                      decoration: const BoxDecoration(
                                        color: CustomColor.gray03,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '하트 코인 충전',
                                            style: CustomText.body10.copyWith(
                                              color: CustomColor.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4,),
                                          Text(
                                            '영양사료 할인쿠폰 또는 디지털트윈이용\n옷, 침대, 장신구 등으로 교환할 수 있어요!',
                                            style: CustomText.caption3.copyWith(
                                              color: CustomColor.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: fnGetDeviceWidth(context) / 3 + 96,
                                height: fnGetDeviceWidth(context) / 3,
                                decoration: const BoxDecoration(
                                  color: CustomColor.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                margin: const EdgeInsets.only(right: 16),
                                child: Column(
                                  children: [
                                    Container(
                                      width: fnGetDeviceWidth(context) / 3 + 96,
                                      height: fnGetDeviceWidth(context) / 6,
                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                      /* child: Image.asset(
                                        'assets/icons/preorder/0001/certificate.png',
                                      ), */
                                    ),
                                    Container(
                                      width: fnGetDeviceWidth(context) / 3 + 96,
                                      height: fnGetDeviceWidth(context) / 6,
                                      decoration: const BoxDecoration(
                                        color: CustomColor.gray03,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '영양 사료 할인 쿠폰',
                                            style: CustomText.body10.copyWith(
                                              color: CustomColor.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4,),
                                          Text(
                                            '건강 상태를 분석해\n기존 사료에 영양제를 배합해드려요 :)',
                                            style: CustomText.caption3.copyWith(
                                              color: CustomColor.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32,),
                      SizedBox(
                        width: fnGetDeviceWidth(context),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                width: fnGetDeviceWidth(context) / 3 + 96,
                                height: fnGetDeviceWidth(context) / 3,
                                decoration: const BoxDecoration(
                                  color: CustomColor.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                margin: const EdgeInsets.only(right: 16),
                                child: Column(
                                  children: [
                                    Container(
                                      width: fnGetDeviceWidth(context) / 3 + 96,
                                      height: fnGetDeviceWidth(context) / 6,
                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                      /* child: Image.asset(
                                        'assets/icons/preorder/0001/certificate.png',
                                      ), */
                                    ),
                                    Container(
                                      width: fnGetDeviceWidth(context) / 3 + 96,
                                      height: fnGetDeviceWidth(context) / 6,
                                      decoration: const BoxDecoration(
                                        color: CustomColor.gray03,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '얼리어답터 토큰',
                                            style: CustomText.body10.copyWith(
                                              color: CustomColor.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4,),
                                          Text(
                                            '포프린트의 역사적인 첫 시작을 함께하는\n여러분들께만 드리는 리미티드 토큰',
                                            style: CustomText.caption3.copyWith(
                                              color: CustomColor.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: fnGetDeviceWidth(context) / 3 + 96,
                                height: fnGetDeviceWidth(context) / 3,
                                decoration: const BoxDecoration(
                                  color: CustomColor.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                margin: const EdgeInsets.only(right: 16),
                                child: Column(
                                  children: [
                                    Container(
                                      width: fnGetDeviceWidth(context) / 3 + 96,
                                      height: fnGetDeviceWidth(context) / 6,
                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                      /* child: Image.asset(
                                        'assets/icons/preorder/0001/certificate.png',
                                      ), */
                                    ),
                                    Container(
                                      width: fnGetDeviceWidth(context) / 3 + 96,
                                      height: fnGetDeviceWidth(context) / 6,
                                      decoration: const BoxDecoration(
                                        color: CustomColor.gray03,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '영양 사료 정기 구독 혜택',
                                            style: CustomText.body10.copyWith(
                                              color: CustomColor.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4,),
                                          Text(
                                            '같은 사료 가격, 다른 맞춤 사료 케어 서비스\n영양 사료 첫 달 70% 할인',
                                            style: CustomText.caption3.copyWith(
                                              color: CustomColor.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: fnGetDeviceWidth(context) / 3 + 96,
                                height: fnGetDeviceWidth(context) / 3,
                                decoration: const BoxDecoration(
                                  color: CustomColor.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                margin: const EdgeInsets.only(right: 16),
                                child: Column(
                                  children: [
                                    Container(
                                      width: fnGetDeviceWidth(context) / 3 + 96,
                                      height: fnGetDeviceWidth(context) / 6,
                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                      /* child: Image.asset(
                                        'assets/icons/preorder/0001/certificate.png',
                                      ), */
                                    ),
                                    Container(
                                      width: fnGetDeviceWidth(context) / 3 + 96,
                                      height: fnGetDeviceWidth(context) / 6,
                                      decoration: const BoxDecoration(
                                        color: CustomColor.gray03,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '월간 건강 레포트 전송',
                                            style: CustomText.body10.copyWith(
                                              color: CustomColor.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4,),
                                          Text(
                                            '활동량 + 수면량 + 변 상태 분석 후,\n다른 반려동물과의 건강 비교 분석 레포트',
                                            style: CustomText.caption3.copyWith(
                                              color: CustomColor.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 64,),
                    ],
                  ),
                ),
                // const SizedBox(height: 32,),
              ],
            )
          ),
        ),
      ),
    );
  }
}
