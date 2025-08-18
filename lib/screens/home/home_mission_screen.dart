import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/model/poop_status_model.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';

class HomeMissionScreen extends ConsumerStatefulWidget {
  const HomeMissionScreen({
    super.key,
    this.missionTitle = '',
    this.missionCont = '',
  });

  final String missionTitle;
  final String missionCont;

  @override
  ConsumerState<HomeMissionScreen> createState() => HomeMissionScreenState();
}

class HomeMissionScreenState extends ConsumerState<HomeMissionScreen> with HomeController, MyController {

  @override
  void initState() {
    super.initState();
    fnInitHomeController(ref, context);
  }

  @override
  Widget build(BuildContext context) {
    final homeActivatedPetNavState = ref.watch(homeActivatedPetNavProvider);
    final responseDogsState = ref.watch(responseDogsProvider);
    final responsePooMonthlyMeanState = ref.watch(responsePooMonthlyMeanProvider);

    // TODO : 현재 월에 해당하는 데이터를 불러올 수 있도록 세팅
    final monthlyPoopList = responsePooMonthlyMeanState.monthly_poop_list.map((e) => PoopStatusModel.fromJson(e as Map<String, dynamic>)).toList();
    final grade = monthlyPoopList.firstWhere((elem) => elem.date == DateTime.now().toString().substring(0, 10), orElse: () => PoopStatusModel(date: '', grade: '')).grade;

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
                        image: AssetImage('assets/icons/mission/${widget.missionCont}_${
                          fnGetPetTypesIndexByCode(responseDogsState[homeActivatedPetNavState].division2_code) % 3 == 0 ? 
                            'white' : 
                            fnGetPetTypesIndexByCode(responseDogsState[homeActivatedPetNavState].division2_code) % 3 == 1 ? 
                              'yellow' : 'black'
                        }.gif'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8),),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  DefaultTextButton(
                    text: '${widget.missionTitle} 완료하기', 
                    disabled: false,
                    borderColor: widget.missionCont != 'taking_pictures_of_poop' ||
                                 (widget.missionCont == 'taking_pictures_of_poop' && grade.isNotEmpty) ?
                                CustomColor.yellow03 : 
                                CustomColor.gray04,
                    backgroundColor: widget.missionCont != 'taking_pictures_of_poop' ||
                                 (widget.missionCont == 'taking_pictures_of_poop' && grade.isNotEmpty) ?
                                CustomColor.yellow03 : 
                                CustomColor.gray04,
                    textColor: widget.missionCont != 'taking_pictures_of_poop' ||
                                 (widget.missionCont == 'taking_pictures_of_poop' && grade.isNotEmpty) ?
                                CustomColor.black : 
                                CustomColor.gray03,
                    width: fnGetDeviceWidth(context),
                    onPressed: () {
                      if(widget.missionCont != 'taking_pictures_of_poop' ||
                         (widget.missionCont == 'taking_pictures_of_poop' && grade.isNotEmpty)
                        ) {
                        showAlertDialog(
                          context: context, 
                          middleText: '${widget.missionTitle} 미션을 완료했어요!',
                          onConfirm: () {
                            context.pop();
                          }
                        );
                      } else if(widget.missionCont == 'taking_pictures_of_poop' && grade.isEmpty) {
                        showAlertDialog(
                          context: context, 
                          middleText: '오늘의 ${widget.missionTitle} 미션을 수행해 주세요',
                        );
                      }
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