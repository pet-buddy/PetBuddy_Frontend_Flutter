import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';

class HomeMissionScreen extends ConsumerStatefulWidget {
  const HomeMissionScreen({
    super.key,
    this.missionCont = '',
    this.missionGif = '',
  });

  final String missionCont;
  final String missionGif;

  @override
  ConsumerState<HomeMissionScreen> createState() => HomeMissionScreenState();
}

class HomeMissionScreenState extends ConsumerState<HomeMissionScreen> with HomeController {

  @override
  void initState() {
    super.initState();
    fnInitHomeController(ref, context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '미션 화면',
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
          // TODO : 상태 초기화
          
          context.pop();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16), // 필요할 경우 조정
              child: Column(
                children: [
                  const SizedBox(height: 16,),
                  Container(
                    width: fnGetDeviceWidth(context),
                    height: fnGetDeviceWidth(context),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.missionGif),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8),),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  DefaultTextButton(
                    text: '${widget.missionCont} 미션완료', 
                    disabled: false,
                    borderColor: CustomColor.yellow03,
                    backgroundColor: CustomColor.yellow03,
                    width: fnGetDeviceWidth(context),
                    onPressed: () {

                    },
                  ),
                  const SizedBox(height: 16,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}