import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:petbuddy_frontend_flutter/screens/home/widget/widget.dart';

class HomeSleepReportScreen extends ConsumerStatefulWidget {
  const HomeSleepReportScreen({super.key});

  @override
  ConsumerState<HomeSleepReportScreen> createState() => HomeSleepReportScreenState();
}

class HomeSleepReportScreenState extends ConsumerState<HomeSleepReportScreen> with HomeController, MyController {

  @override
  void initState() {
    super.initState();
    fnInitHomeController(ref, context);
  }

  @override
  Widget build(BuildContext context) {
    final homeActivatedPetNavState = ref.watch(homeActivatedPetNavProvider);
    final responseDogsState = ref.watch(responseDogsProvider);
    final homeSleepReportPeriodSelectState = ref.watch(homeSleepReportPeriodSelectProvider);
    final homeSleepReportBenchmarkSleepEfficiencyState = ref.watch(homeSleepReportBenchmarkSleepEfficiencyProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 벤치마크 반려동물 수면효율
      ref.read(homeSleepReportBenchmarkSleepEfficiencyProvider.notifier).set(
        fnGetBenchmarkSleepEfficiency(
          responseDogsState[homeActivatedPetNavState].pet_size, 
          fnGetDaysDiff(responseDogsState[homeActivatedPetNavState].pet_birth),
        ).percent,
      );
    });

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '수면 보고서',
        leadingOnPressed: () {
          if(!context.mounted) return;
          fnInvalidateHomeSleepReportState();
          context.pop();
        },
        actionIcon: 'assets/icons/action/open_info_window.svg',
        actionOnPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const HomeSleepReportInfoDialog(),
          );
        },
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          // TODO : 상태 초기화
          fnInvalidateHomeSleepReportState();
          context.pop();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0), // 필요할 경우 조정
              child: Column(
                children: [
                  const SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '수면 레포트',
                          style: CustomText.heading4.copyWith(
                            color: CustomColor.blue03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            color: CustomColor.gray05,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              HomeSleepReportPeriodButton(
                                width: 64, 
                                backgroundColor: homeSleepReportPeriodSelectState == 'D' ?
                                  CustomColor.yellow03 :
                                  CustomColor.gray05,
                                text: '일간', 
                                textColor: homeSleepReportPeriodSelectState == 'D' ?
                                  CustomColor.black :
                                  CustomColor.gray04, 
                                onPressed: () {
                                  ref.read(homeSleepReportPeriodSelectProvider.notifier).set('D');
                                  homeSleepReportScreenPeriodController.jumpToPage(0);
                                }
                              ),
                              const SizedBox(width: 8,),
                              HomeSleepReportPeriodButton(
                                width: 64, 
                                backgroundColor: homeSleepReportPeriodSelectState == 'W' ?
                                  CustomColor.yellow03 :
                                  CustomColor.gray05,
                                text: '주간', 
                                textColor: homeSleepReportPeriodSelectState == 'W' ?
                                  CustomColor.black :
                                  CustomColor.gray04, 
                                onPressed: () {
                                  ref.read(homeSleepReportPeriodSelectProvider.notifier).set('W');
                                  homeSleepReportScreenPeriodController.jumpToPage(1);
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: fnGetDeviceWidth(context),
                          height: fnGetDeviceWidth(context),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: PageView(
                            controller: homeSleepReportScreenPeriodController,
                            padEnds: false,
                            onPageChanged: (index) {
                              index == 0 ?
                                ref.read(homeSleepReportPeriodSelectProvider.notifier).set('D') :
                                ref.read(homeSleepReportPeriodSelectProvider.notifier).set('W');
                            },
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '수면 평가',
                                        style: CustomText.body10.copyWith(
                                          color: CustomColor.gray04
                                        ),
                                      ),
                                      const SizedBox(width: 4,),
                                      Text(
                                        '??',
                                        style: CustomText.body2.copyWith(
                                          color: CustomColor.gray04,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      HomeSleepCircleChartContainer(
                                        title: "주간",
                                        time: "06~18시",
                                        sleepTime: [
                                          HomeSleepTimeRangeModel(0.0, 0.2, CustomColor.yellow03),
                                          HomeSleepTimeRangeModel(0.3, 0.5, CustomColor.blue03),
                                        ],
                                      ),
                                      HomeSleepCircleChartContainer(
                                        title: "야간",
                                        time: "18~06시",
                                        sleepTime: [
                                          HomeSleepTimeRangeModel(0.0, 0.2, CustomColor.deepYellow),
                                          HomeSleepTimeRangeModel(0.7, 0.85, CustomColor.deepBlue),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const HomeSleepEfficiencyChartContainer(
                                sleepScore: [95, 60, 75, 88, 65, 82, 70],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16,),
                        Text(
                          '주간 수면 상태 Summary',
                          style: CustomText.heading4.copyWith(
                            color: CustomColor.blue03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        RichText(
                          text: TextSpan(
                            text: '오후 2시경',
                            style: CustomText.body11.copyWith(
                              color: CustomColor.deepYellow
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' 가장 많이 잤고',
                                style: CustomText.body11.copyWith(
                                  color: CustomColor.deepBlue
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '권장 수면시간대와',
                            style: CustomText.body11.copyWith(
                              color: CustomColor.deepBlue
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' 약 n시간',
                                style: CustomText.body11.copyWith(
                                  color: CustomColor.deepYellow
                                ),
                              ),
                              const TextSpan(
                                text: ' 차이나요',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Text(
                          '푸들 권장 수면 시간은 오후 n시부터 오전 n시입니다',
                          style: CustomText.body11.copyWith(
                            color: CustomColor.blue06,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        HomeHorizontalBarChartContainer(
                          text: responseDogsState.isNotEmpty ? 
                            '${responseDogsState[homeActivatedPetNavState].pet_name} 수면 효율도 50%' :
                            '반려동물 수면 효율도 50%',
                          score: 50,
                          flag: 'sleep',
                        ),
                        HomeHorizontalBarChartContainer(
                          text: '${fnGetDogSizeKorName(responseDogsState[homeActivatedPetNavState].pet_size)} 평균 수면 효율도 $homeSleepReportBenchmarkSleepEfficiencyState%',
                          textColor: CustomColor.deepYellow,
                          barColor: CustomColor.yellow03,
                          score: homeSleepReportBenchmarkSleepEfficiencyState,
                          flag: 'sleep',
                        ),
                        const SizedBox(height: 16,),
                        HomeReportContainerLayout(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '주간 수면 추천 Advice',
                                style: CustomText.heading4.copyWith(
                                  color: CustomColor.blue03,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Text(
                                responseDogsState.isNotEmpty ? 
                                  '${responseDogsState[homeActivatedPetNavState].pet_name}의 편안한 수면을 도울 수 있는 팁이에요!' :
                                  '반려동물의 편안한 수면을 도울 수 있는 팁이에요!',
                                style: CustomText.body9.copyWith(
                                  color: CustomColor.deepBlue,
                                ),
                              ),
                              const SizedBox(height: 8,),
                              for(int i=0;i<3;i++)
                                SizedBox(
                                  width: fnGetDeviceWidth(context),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          sleepRecommandedAdvice[i].svgPicture,
                                          const SizedBox(width: 4,),
                                          Text(
                                            sleepRecommandedAdvice[i].title,
                                            style: CustomText.body11.copyWith(
                                              color: CustomColor.blue03,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4,),
                                      Text(
                                        sleepRecommandedAdvice[i].text,
                                        style: CustomText.body11.copyWith(
                                          color: CustomColor.deepBlue,
                                        ),
                                      ),
                                      const SizedBox(height: 8,),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16,),
                      ],
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