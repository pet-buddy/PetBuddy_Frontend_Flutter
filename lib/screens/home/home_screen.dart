import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16,),
                  const Text(
                    '탄이, 반가워요!',
                    style: CustomText.heading1,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/etc/heart.svg',
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 8,),
                      const Text(
                        '하트코인(준비 중)',
                        style: CustomText.body10,
                      ),
                      const SizedBox(width: 16,),
                      Text(
                        NumberFormat('###,###,###,###').format(1350),
                        style: CustomText.body10,
                      ),
                    ],
                  ),
                  OutlinedButton(onPressed: () {
                    //context.goNamed("home_activity_report_screen");
                    showAlertDialog(context: context, middleText: 'teeeee');
                  }, child: Text('test'))
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
