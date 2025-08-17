import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';

class MyFitbarkWebScreen extends ConsumerStatefulWidget {
  const MyFitbarkWebScreen({super.key});

  @override
  ConsumerState<MyFitbarkWebScreen> createState() => MyFitbarkWebScreenState();
}

class MyFitbarkWebScreenState extends ConsumerState<MyFitbarkWebScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responseUserMypageState = ref.watch(responseUserMypageProvider);
    
    return DefaultLayout(
      backgroundColor: CustomColor.gray05,
      appBar: DefaultAppBar(
        title: 'Fitbark 연동하기',
        leadingDisable: false,
        actionDisable: true,
        leadingOnPressed: () {
          context.pop();
        },
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
        child: const SafeArea(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: HtmlElementView(viewType: 'fitbark-iframe'),
          ),
        ),
      ),
    );
  }
}