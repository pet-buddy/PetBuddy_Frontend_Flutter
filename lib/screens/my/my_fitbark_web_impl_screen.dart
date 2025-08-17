import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/html.dart' as html;

class MyFitbarkWebScreen extends ConsumerStatefulWidget {
  const MyFitbarkWebScreen({super.key});

  @override
  ConsumerState<MyFitbarkWebScreen> createState() => MyFitbarkWebScreenState();
}

class MyFitbarkWebScreenState extends ConsumerState<MyFitbarkWebScreen> {
  @override
  void initState() {
    super.initState();

    html.window.open('https://app.fitbark.com/web/login', '_blank');

    // iframe 등록
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'fitbark-iframe',
      (int viewId) {
        final iframe = IFrameElement()
          ..src = 'assets/html/fitbark.html'
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';
        return iframe;
      },
    );
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
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              width: fnGetDeviceWidth(context),
              height: MediaQuery.of(context).size.height,
              child: const HtmlElementView(viewType: 'fitbark-iframe')
            ),
          ),
        ),
      ),
    );
  }
}