import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';

class MyFitbarkScreen extends ConsumerStatefulWidget {
  const MyFitbarkScreen({super.key});

  @override
  ConsumerState<MyFitbarkScreen> createState() => MyFitbarkScreenState();
}

class MyFitbarkScreenState extends ConsumerState<MyFitbarkScreen> with MyController {

  InAppWebViewController? inAppWebViewController;

  @override
  void initState() {
    super.initState();
    fnInitMyController(ref, context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final responseUserMypageState = ref.watch(responseUserMypageProvider);
    final responseDogsState = ref.watch(responseDogsProvider);
    final homeActivatedPetNavState = ref.watch(homeActivatedPetNavProvider);
    
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
              child: InAppWebView(
                initialFile: 'assets/web/fitbark.html',
                initialSettings: InAppWebViewSettings(javaScriptEnabled: true),
                onWebViewCreated: (controller) async {
                  inAppWebViewController = controller;
                },
                onLoadStop: (controller, url) async {
                  // 계속 호출되는 문제가 있어 로컬 HTML 로드 시 한번만 호출
                  if(!url.toString().contains('https://app.fitbark.com/')) {
                    // user_id 할당
                    await controller.evaluateJavascript(source: """
                      document.getElementById('state').value = '${
                        responseUserMypageState.user_id.toString()},
                        ${responseDogsState[homeActivatedPetNavState].pet_id}';
                    """);
                  } 
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}