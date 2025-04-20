import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/home_activity_report_period_select_provider.dart';
import 'package:petbuddy_frontend_flutter/screens/home/widget/widget.dart';

class HomeActivityReportScreen extends ConsumerStatefulWidget {
  const HomeActivityReportScreen({super.key});

  @override
  ConsumerState<HomeActivityReportScreen> createState() => HomeActivityReportScreenState();
}

class HomeActivityReportScreenState extends ConsumerState<HomeActivityReportScreen> with HomeController {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeActivityReportPeriodSelectState = ref.watch(homeActivityReportPeriodSelectProvider);

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '활동량 보고서',
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // const SizedBox(height: 16,),
                  Container(
                    width: fnGetDeviceWidth(context),
                    height: 32,
                    decoration: const BoxDecoration(
                      color: CustomColor.yellow03,
                      borderRadius: BorderRadius.all(Radius.circular(8),),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            HomeActivityReportPeriodButton(
                              width:  (fnGetDeviceWidth(context) - 4) / 6, 
                              color:  homeActivityReportPeriodSelectState == periodCode['Day']! 
                                ? CustomColor.white 
                                : CustomColor.yellow03,
                              text:  periodCode['Day']!, 
                              onPressed: () {
                                ref.watch(homeActivityReportPeriodSelectProvider.notifier)
                                   .set(periodCode['Day']!);
                              }
                            ),
                            Container(
                              width: 1,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: const BoxDecoration(
                                color: CustomColor.gray02,
                              ),
                            ),
                            HomeActivityReportPeriodButton(
                              width: (fnGetDeviceWidth(context) - 4) / 6, 
                              color: homeActivityReportPeriodSelectState == periodCode['Week']! 
                                ? CustomColor.white 
                                : CustomColor.yellow03,
                              text: periodCode['Week']!, 
                              onPressed: () {
                                ref.watch(homeActivityReportPeriodSelectProvider.notifier)
                                   .set(periodCode['Week']!);
                              }
                            ),
                            Container(
                              width: 1,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: const BoxDecoration(
                                color: CustomColor.gray02,
                              ),
                            ),
                            HomeActivityReportPeriodButton(
                              width: (fnGetDeviceWidth(context) - 4) / 6, 
                              color: homeActivityReportPeriodSelectState == periodCode['Month']! 
                                ? CustomColor.white 
                                : CustomColor.yellow03,
                              text: periodCode['Month']!, 
                              onPressed: () {
                                ref.watch(homeActivityReportPeriodSelectProvider.notifier)
                                   .set(periodCode['Month']!);
                              }
                            ),
                            Container(
                              width: 1,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: const BoxDecoration(
                                color: CustomColor.gray02,
                              ),
                            ),
                            HomeActivityReportPeriodButton(
                              width: (fnGetDeviceWidth(context) - 4) / 6, 
                              color: homeActivityReportPeriodSelectState == periodCode['6Month']! 
                                ? CustomColor.white 
                                : CustomColor.yellow03,
                              text: periodCode['6Month']!, 
                              onPressed: () {
                                ref.watch(homeActivityReportPeriodSelectProvider.notifier)
                                   .set(periodCode['6Month']!);
                              }
                            ),
                            Container(
                              width: 1,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: const BoxDecoration(
                                color: CustomColor.gray02,
                              ),
                            ),
                            HomeActivityReportPeriodButton(
                              width: (fnGetDeviceWidth(context) - 4) / 6,
                              color: homeActivityReportPeriodSelectState == periodCode['Year']! 
                                ? CustomColor.white 
                                : CustomColor.yellow03, 
                              text: periodCode['Year']!, 
                              onPressed: () {
                                ref.watch(homeActivityReportPeriodSelectProvider.notifier)
                                   .set(periodCode['Year']!);
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  // 그래프
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '하이라이트',
                          style: CustomText.heading4.copyWith(
                            color: CustomColor.blue03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        const Text(
                          '혹시 7시에 무슨 일이 있었나요?\n반려동물이 흥분을 감추지 못했어요.',
                          style: CustomText.body11,
                        ),
                      ],
                    ),
                  ),
                  // 활동량 분석 
                  HomeActivityReportContainer(
                    periodCode: homeActivityReportPeriodSelectState, 
                    assessment: '탄이보다 보호자님이 더 활동적이었군요!\n탄이가 섭섭하지 않도록 활동량을 늘려주세요 :)'
                  ),
                  const SizedBox(height: 16,),
                  // 종합평가
                  HomeActivityReportTotalContainer(
                    periodCode: homeActivityReportPeriodSelectState, 
                    evaluation: '평균 노년견 푸들 대비 활동량이 낮습니다.\n보호자님이 많이 걸으신 만큼, 탄이와도 함께 많이 걸어다니세요!',
                    petName: '탄이',
                    petActivity: '대형백화점 1바퀴',
                    petActivityDistance: '0.5',
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
