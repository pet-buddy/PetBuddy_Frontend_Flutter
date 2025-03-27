import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/home_activity_report_period_select_provider.dart';

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
                            wgActivityReportPeriodSelectContent(
                              MediaQuery.of(context).size.width / 6, 
                              homeActivityReportPeriodSelectState == periodCode['Day']! 
                                ? CustomColor.white 
                                : CustomColor.yellow03,
                              periodCode['Day']!, 
                              () {
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
                            wgActivityReportPeriodSelectContent(
                              MediaQuery.of(context).size.width / 6, 
                              homeActivityReportPeriodSelectState == periodCode['Week']! 
                                ? CustomColor.white 
                                : CustomColor.yellow03,
                              periodCode['Week']!, 
                              () {
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
                            wgActivityReportPeriodSelectContent(
                              MediaQuery.of(context).size.width / 6, 
                              homeActivityReportPeriodSelectState == periodCode['Month']! 
                                ? CustomColor.white 
                                : CustomColor.yellow03,
                              periodCode['Month']!, 
                              () {
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
                            wgActivityReportPeriodSelectContent(
                              MediaQuery.of(context).size.width / 6, 
                              homeActivityReportPeriodSelectState == periodCode['6Month']! 
                                ? CustomColor.white 
                                : CustomColor.yellow03,
                              periodCode['6Month']!, 
                              () {
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
                            wgActivityReportPeriodSelectContent(
                              MediaQuery.of(context).size.width / 6,
                              homeActivityReportPeriodSelectState == periodCode['Year']! 
                                ? CustomColor.white 
                                : CustomColor.yellow03, 
                              periodCode['Year']!, 
                              () {
                                ref.watch(homeActivityReportPeriodSelectProvider.notifier)
                                   .set(periodCode['Year']!);
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
