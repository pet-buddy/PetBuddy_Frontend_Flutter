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

    // iframe 등록
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'fitbark-iframe',
      (int viewId) {
        final iframe = IFrameElement()
          ..src = 'assets/web/fitbark_web.html'
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.overflow = 'auto';

        iframe.onLoad.listen((event) {
          // 변수명을 user_id로 하려고 했으나 통일성을 위해 lowerCamelCase로 
          final userId = ref.read(responseUserMypageProvider.notifier).get().user_id;
          final dogs = ref.read(responseDogsProvider.notifier).get();
          final activatedPetNav = ref.read(homeActivatedPetNavProvider.notifier).get();

          try {
            final win = iframe.contentWindow;

            if (win is html.Window) {
              final doc = win.document;
              final stateInput = doc.getElementById("state") as html.InputElement?;

              if (stateInput != null) {
                stateInput.value = '${userId.toString()},${dogs[activatedPetNav].pet_id}';
              } else {
                // debugPrint('DOM 요소를 찾을 수 없습니다.');

                showAlertDialog(
                  context: context, 
                  middleText: 'DOM 요소를 찾을 수 없습니다.',
                );
              }
            }
          } catch (e) {
            // debugPrint(e.toString());

            showAlertDialog(
              context: context, 
              middleText: 'DOM 요소를 찾을 수 없습니다.\n$e',
            );
          }
        });
        
        return iframe;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: const HtmlElementView(viewType: 'fitbark-iframe'),
              );
            },
          ),
        ),
      ),
    );
  }
}