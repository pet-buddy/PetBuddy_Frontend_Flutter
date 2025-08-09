import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/screens/home/widget/widget.dart';

class HomeSleepReportScreen extends ConsumerStatefulWidget {
  const HomeSleepReportScreen({super.key});

  @override
  ConsumerState<HomeSleepReportScreen> createState() => HomeSleepReportScreenState();
}

class HomeSleepReportScreenState extends ConsumerState<HomeSleepReportScreen> with HomeController {

  @override
  void initState() {
    super.initState();
    fnInitHomeController(ref, context);
  }

  @override
  Widget build(BuildContext context) {

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '수면 보고서',
        leadingOnPressed: () {
          if(!context.mounted) return;
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
                          '수면레포트',
                          style: CustomText.heading4.copyWith(
                            color: CustomColor.blue03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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