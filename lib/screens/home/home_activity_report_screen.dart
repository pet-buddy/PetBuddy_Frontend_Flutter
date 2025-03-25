import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';

class HomeActivityReportScreen extends ConsumerStatefulWidget {
  const HomeActivityReportScreen({super.key});

  @override
  ConsumerState<HomeActivityReportScreen> createState() => HomeActivityReportScreenState();
}

class HomeActivityReportScreenState extends ConsumerState<HomeActivityReportScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 6,
                                decoration: const BoxDecoration(
                                  color: CustomColor.white,
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                ),
                                child: Text(
                                  'D'
                                ),
                              ),
                            ),
                            const SizedBox(width: 4,),
                            Container(
                              width: 1,
                              decoration: const BoxDecoration(
                                color: CustomColor.gray02
                              ),
                            ),
                            const SizedBox(width: 4,),
                            GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 6,
                                decoration: const BoxDecoration(
                                  color: CustomColor.yellow03,
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                ),
                                child: Text(
                                  'W'
                                ),
                              ),
                            ),
                            const SizedBox(width: 4,),
                            Container(
                              width: 1,
                              decoration: const BoxDecoration(
                                color: CustomColor.gray02
                              ),
                            ),
                            const SizedBox(width: 4,),
                            GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 6,
                                decoration: const BoxDecoration(
                                  color: CustomColor.yellow03,
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                ),
                                child: Text(
                                  'M'
                                ),
                              ),
                            ),
                            const SizedBox(width: 4,),
                            Container(
                              width: 1,
                              decoration: const BoxDecoration(
                                color: CustomColor.gray02
                              ),
                            ),
                            const SizedBox(width: 4,),
                            GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 6,
                                decoration: const BoxDecoration(
                                  color: CustomColor.yellow03,
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                ),
                                child: Text(
                                  '6M'
                                ),
                              ),
                            ),
                            const SizedBox(width: 4,),
                            Container(
                              width: 1,
                              decoration: const BoxDecoration(
                                color: CustomColor.gray02
                              ),
                            ),
                            const SizedBox(width: 4,),
                            GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 6,
                                decoration: const BoxDecoration(
                                  color: CustomColor.yellow03,
                                  borderRadius: BorderRadius.all(Radius.circular(8),),
                                ),
                                child: Text(
                                  'Y'
                                ),
                              ),
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
