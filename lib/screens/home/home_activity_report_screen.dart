import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                    width: MediaQuery.of(context).size.width,
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
                              width:  (MediaQuery.of(context).size.width - 4) / 6, 
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
                              width: (MediaQuery.of(context).size.width - 4) / 6, 
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
                              width: (MediaQuery.of(context).size.width - 4) / 6, 
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
                              width: (MediaQuery.of(context).size.width - 4) / 6, 
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
                              width: (MediaQuery.of(context).size.width - 4) / 6,
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

                  // 활동량 분석 
                  HomeActivityReportContainer(
                    periodCode: homeActivityReportPeriodSelectState, 
                    assessment: '탄이보다 보호자님이 더 활동적이었군요!\n탄이가 섭섭하지 않도록 활동량을 늘려주세요 :)'
                  ),
                  // 종합평가
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
