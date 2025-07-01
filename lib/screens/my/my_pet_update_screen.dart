// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:petbuddy_frontend_flutter/screens/my/widget/custom_time_picker_dialog.dart';

class MyPetUpdateScreen extends ConsumerStatefulWidget {
  const MyPetUpdateScreen({
    super.key,
    this.pet_id = -1,
  });

  final int pet_id;

  @override
  ConsumerState<MyPetUpdateScreen> createState() => MyPetUpdateScreenState();
}

class MyPetUpdateScreenState extends ConsumerState<MyPetUpdateScreen> with MyController {

  @override
  void initState() {
    super.initState();
    fnInitMyController(ref, context);
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final petIndex = ref.read(responseDogsProvider.notifier).get().indexWhere((item) => item.pet_id == widget.pet_id);
      // 반려동물 상태 세팅
      fnInitMyPetUpdateState(ref.read(responseDogsProvider.notifier).get()[petIndex]);
    });
  }

  @override
  void dispose() {
    petNameInputController.dispose();
    petTypeInputController.dispose();
    petTypeScrollController.dispose();
    petFeedInputController.dispose();
    petFeedScrollController.dispose();
    super.dispose();
  }

  TimeOfDay initialTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final myPetUpdateTypeFilterState = ref.watch(myPetAddTypeFilterProvider);
    final myPetUpdateTypeDropdownState = ref.watch(myPetAddTypeDropdownProvider);
    final myPetUpdateFeedFilterState = ref.watch(myPetAddFeedFilterProvider);
    final myPetUpdateFeedDropdownState = ref.watch(myPetAddFeedDropdownProvider);
    final myPetUpdateSizeButtonState = ref.watch(myPetAddSizeButtonProvider);
    final myPetUpdateGenderButtonState = ref.watch(myPetAddGenderButtonProvider);
    final myPetUpdateNeuterButtonState = ref.watch(myPetAddNeuterButtonProvider);
    final myPetUpdateFeedAmountButtonState = ref.watch(myPetAddFeedAmountButtonProvider);
    final myPetUpdateNameInputStatusCodeState = ref.watch(myPetAddNameInputStatusCodeProvider);
    final myPetUpdateBirthInputStatusCodeState = ref.watch(myPetAddBirthInputStatusCodeProvider);
    final myPetUpdateButtonState = ref.watch(myPetUpdateButtonProvider);
    final requestUpdateDogState = ref.watch(requestUpdateDogProvider);
    final myPetUpdateFeedTimeListState = ref.watch(myPetAddFeedTimeListProvider);
    final myPetUpdateFeedTimeDeleteListState = ref.watch(myPetAddFeedTimeDeleteListProvider);
    final myPetUpdateFeedTimeSelectModeState = ref.watch(myPetAddFeedTimeSelectModeProvider);
    
    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '반려동물 수정하기',
        leadingOnPressed: () {
          if(!context.mounted) return;
          fnInvalidateMyPetUpdateState();
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
          if(!context.mounted) return;
          fnInvalidateMyPetUpdateState();
          context.pop();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32,),
                  const Text(
                    '이름',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 5,),
                  OutlinedInput(
                    controller: petNameInputController,
                    onChanged: (String petName) {
                      ref.read(requestUpdateDogProvider.notifier).setPetName(petNameInputController.text);

                      fnCheckPetName(petNameInputController.text);

                      ref.read(myPetUpdateButtonProvider.notifier)
                          .activate(requestUpdateDogState);
                    },
                    keyboardType: TextInputType.text,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    enabledBorder: myPetUpdateNameInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      myPetUpdateNameInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                      CustomColor.negative :
                      CustomColor.gray04,
                    focusedBorder: myPetUpdateNameInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      myPetUpdateNameInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                      CustomColor.negative :
                      CustomColor.gray04,
                  ),
                  Visibility(
                    visible: myPetUpdateNameInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                             myPetUpdateNameInputStatusCodeState != ProjectConstant.INPUT_SUCCESS,
                    child: Column(
                      children: [
                        const SizedBox(height: 4,),
                        Text(
                          myPetUpdateNameInputStatusCodeState == ProjectConstant.INPUT_ERR_EMPTY ?
                            Sentence.PET_NAME_ERR_EMPTY :
                              myPetUpdateNameInputStatusCodeState == ProjectConstant.INPUT_ERR_LENGTH ?
                                Sentence.PET_NAME_ERR_LENGTH :
                                "",
                          style: CustomText.caption3.copyWith(
                            color: CustomColor.negative,
                          ),
                        ),
                      ],
                    )
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '사이즈',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextButton(
                        text: '소형', 
                        disabled: false,
                        borderColor: CustomColor.gray04,
                        backgroundColor: myPetUpdateSizeButtonState == smallSize 
                          ? CustomColor.gray04 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.3,
                        onPressed: () {
                          // ref.read(myPetAddSizeButtonProvider.notifier).set(smallSize); // 화면 업데이트
                          // ref.read(requestUpdateDogProvider.notifier).setPetSize(smallSize); // 데이터 저장

                          // ref.read(myPetUpdateButtonProvider.notifier)
                          //    .activate(requestUpdateDogState); // 수정하기 버튼 활성화 여부
                        },
                      ),
                      DefaultTextButton(
                        text: '중형', 
                        disabled: false,
                        borderColor: CustomColor.gray04,
                        backgroundColor: myPetUpdateSizeButtonState == mediumSize 
                          ? CustomColor.gray04 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.3,
                        onPressed: () {
                          // ref.read(myPetAddSizeButtonProvider.notifier).set(mediumSize);
                          // ref.read(requestUpdateDogProvider.notifier).setPetSize(mediumSize); // 데이터 저장

                          // ref.read(myPetUpdateButtonProvider.notifier)
                          //    .activate(requestUpdateDogState);
                        },
                      ),
                      DefaultTextButton(
                        text: '대형', 
                        disabled: false,
                        borderColor: CustomColor.gray04,
                        backgroundColor: myPetUpdateSizeButtonState == largeSize 
                          ? CustomColor.gray04 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.3,
                        onPressed: () {
                          // ref.read(myPetAddSizeButtonProvider.notifier).set(largeSize);
                          // ref.read(requestUpdateDogProvider.notifier).setPetSize(largeSize); // 데이터 저장

                          // ref.read(myPetUpdateButtonProvider.notifier)
                          //    .activate(requestUpdateDogState);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '품종',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 5,),
                  OutlinedInput(
                    controller: petTypeInputController,
                    onChanged: (String petName) {
                      fnGetFilteredPetTypeItems(petTypeInputController.text);
                    },
                    keyboardType: TextInputType.text,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    hintText: '품종 검색',
                    suffixIcon: IconButton(
                      onPressed: () {
                        !myPetUpdateTypeDropdownState ?
                          fnGetAllPetTypeItems() :
                          ref.read(myPetAddTypeDropdownProvider.notifier).set(!myPetUpdateTypeDropdownState);
                      }, 
                      icon: SvgPicture.asset(
                        'assets/icons/organization/search.svg',
                      ),
                    ),
                  ),
                  if (myPetUpdateTypeDropdownState && myPetUpdateTypeFilterState.isNotEmpty)
                    Container(
                      width: fnGetDeviceWidth(context),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(
                        minHeight: 64,
                        maxHeight: 300,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: CustomColor.gray04),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Scrollbar(
                        controller: petTypeScrollController,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          controller: petTypeScrollController,
                          child: Column(
                            children: myPetUpdateTypeFilterState.map((item) {
                              return ListTile(
                                title: Text(item),
                                onTap: () { 
                                  fnSelectPetTypeItems(item);

                                  ref.read(myPetUpdateButtonProvider.notifier)
                                     .activate(requestUpdateDogState);
                                }
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  const Text(
                    '성별',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextButton(
                        text: '여아', 
                        disabled: false,
                        borderColor: CustomColor.gray04,
                        backgroundColor: myPetUpdateGenderButtonState == femaleCode 
                          ? CustomColor.gray04 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
                          // ref.read(myPetAddGenderButtonProvider.notifier).set(femaleCode);
                          // ref.read(requestUpdateDogProvider.notifier).setPetGender(femaleCode); // 데이터 저장

                          // ref.read(myPetUpdateButtonProvider.notifier)
                          //    .activate(requestUpdateDogState);
                        },
                      ),
                      DefaultTextButton(
                        text: '남아', 
                        disabled: false,
                        borderColor: CustomColor.gray04,
                        backgroundColor: myPetUpdateGenderButtonState == maleCode 
                          ? CustomColor.gray04 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
                          // ref.read(myPetAddGenderButtonProvider.notifier).set(maleCode);
                          // ref.read(requestUpdateDogProvider.notifier).setPetGender(maleCode); // 데이터 저장

                          // ref.read(myPetUpdateButtonProvider.notifier)
                          //    .activate(requestUpdateDogState);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '중성화',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextButton(
                        text: '중성화 전', 
                        disabled: false,
                        borderColor: myPetUpdateNeuterButtonState == neuterN 
                          ? CustomColor.yellow03 
                          : CustomColor.gray04,
                        backgroundColor: myPetUpdateNeuterButtonState == neuterN 
                          ? CustomColor.yellow03 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
                          ref.read(myPetAddNeuterButtonProvider.notifier).set(neuterN);
                          ref.read(requestUpdateDogProvider.notifier).setNeuterYn(false); // 데이터 저장

                          ref.read(myPetUpdateButtonProvider.notifier)
                             .activate(requestUpdateDogState);
                        },
                      ),
                      DefaultTextButton(
                        text: '중성화 완료', 
                        disabled: false,
                        borderColor: myPetUpdateNeuterButtonState == neuterY
                          ? CustomColor.yellow03 
                          : CustomColor.gray04,
                        backgroundColor: myPetUpdateNeuterButtonState == neuterY 
                          ? CustomColor.yellow03 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
                          ref.read(myPetAddNeuterButtonProvider.notifier).set(neuterY);
                          ref.read(requestUpdateDogProvider.notifier).setNeuterYn(true); // 데이터 저장

                          ref.read(myPetUpdateButtonProvider.notifier)
                             .activate(requestUpdateDogState);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '급여 중인 사료',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 5,),
                  OutlinedInput(
                    controller: petFeedInputController,
                    onChanged: (String feedName) {
                      fnGetFilteredPetFeedItems(petFeedInputController.text);
                    },
                    keyboardType: TextInputType.text,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    hintText: '사료 검색',
                    suffixIcon: IconButton(
                      onPressed: () {
                        !myPetUpdateFeedDropdownState ?
                          fnGetAllPetFeedItems() :
                          ref.read(myPetAddFeedDropdownProvider.notifier).set(!myPetUpdateFeedDropdownState);
                      }, 
                      icon: SvgPicture.asset(
                        'assets/icons/organization/search.svg',
                      ),
                    ),
                  ),
                  if (myPetUpdateFeedDropdownState && myPetUpdateFeedFilterState.isNotEmpty)
                    Container(
                      width: fnGetDeviceWidth(context),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(
                        minHeight: 64,
                        maxHeight: 300,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: CustomColor.gray04),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Scrollbar(
                        controller: petFeedScrollController,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          controller: petFeedScrollController,
                          child: Column(
                            children: myPetUpdateFeedFilterState.map((item) {
                              return ListTile(
                                title: Text(item),
                                onTap: () { 
                                  fnSelectPetFeedItems(item);

                                  ref.read(myPetUpdateButtonProvider.notifier)
                                     .activate(requestUpdateDogState);
                                }
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '사료 급여 시간',
                        style: CustomText.body10,
                      ),
                      // GestureDetector(
                      //   onTap: () async {
                      //     await showDialog<void>(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return const CustomTimePickerDialog();
                      //       },
                      //     );
                      //   },
                      //   child: Text(
                      //     '추가 +',
                      //     style: CustomText.body10.copyWith(
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if(myPetUpdateFeedTimeListState.isEmpty) {
                                  showAlertDialog(
                                    context: context, 
                                    middleText: "선택할 사료 급여 시간이 없습니다.",
                                  );
                                  return;
                                }
                                if(myPetUpdateFeedTimeSelectModeState == 'Y') {
                                  ref.read(myPetAddFeedTimeSelectModeProvider.notifier).set('N');
                                  // 급여 시간 삭제 리스트 초기화
                                  ref.read(myPetAddFeedTimeDeleteListProvider.notifier).set([]);
                                } else {
                                  ref.read(myPetAddFeedTimeSelectModeProvider.notifier).set('Y');
                                }
                              },
                              child: Text(
                                '선택',
                                style: CustomText.body10.copyWith(
                                  color: myPetUpdateFeedTimeSelectModeState == 'Y' ?
                                    CustomColor.black :
                                    CustomColor.gray03,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // const SizedBox(width: 8,),
                            GestureDetector(
                              onTap: () async {
                                if(myPetUpdateFeedTimeSelectModeState != 'Y') {
                                  showAlertDialog(
                                    context: context, 
                                    middleText: "'선택'을 클릭하여 주세요."
                                  );
                                  return;
                                }
                                if(myPetUpdateFeedTimeSelectModeState == 'Y' && myPetUpdateFeedTimeDeleteListState.isEmpty) {
                                  showAlertDialog(
                                    context: context, 
                                    middleText: "삭제할 사료 급여 시간을 선택해주세요.",
                                  );
                                  return;
                                }

                                List<int> indices = [];
                                // 삭제 리스트에 있는 요소(인덱스)를 변수에 담기
                                for(int i=0;i<myPetUpdateFeedTimeDeleteListState.length;i++) {
                                  indices.add(myPetUpdateFeedTimeDeleteListState[i]);
                                }
                                // 급여 시간 리스트 삭제
                                ref.read(myPetAddFeedTimeListProvider.notifier).removeMultipleAt(indices);
                                // 삭제 리스트 초기화
                                ref.read(myPetAddFeedTimeDeleteListProvider.notifier).set([]);
                                // 사료 급여 시간 값 세팅
                                myRef.read(requestUpdateDogProvider.notifier).setFeedTime(
                                  myRef.read(myPetAddFeedTimeListProvider.notifier).get(),
                                );
                                // 추가하기 버튼 상태 체크
                                ref.read(myPetUpdateButtonProvider.notifier)
                                   .activate(requestUpdateDogState);
                              },
                              child: Text(
                                '삭제 -',
                                style: CustomText.body10.copyWith(
                                  color: myPetUpdateFeedTimeSelectModeState == 'Y' && myPetUpdateFeedTimeDeleteListState.isNotEmpty ?
                                    CustomColor.black :
                                    CustomColor.gray03,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  for(int i=0;i<myPetUpdateFeedTimeListState.length;i++)
                    Column(
                      children: [
                        DefaultTextButton(
                        text: fnConvertTime24To12(myPetUpdateFeedTimeListState[i]),
                        disabled: false,
                        borderColor: myPetUpdateFeedTimeSelectModeState == 'Y' && myPetUpdateFeedTimeDeleteListState.contains(i) ? 
                                     CustomColor.negative : 
                                     CustomColor.gray04,
                        backgroundColor: myPetUpdateFeedTimeSelectModeState == 'Y' && myPetUpdateFeedTimeDeleteListState.contains(i) ?
                                          CustomColor.negative :
                                             myPetUpdateFeedTimeSelectModeState == 'Y'  ?
                                              CustomColor.gray04 : 
                                              CustomColor.white,
                        textColor: myPetUpdateFeedTimeSelectModeState == 'Y' && myPetUpdateFeedTimeDeleteListState.contains(i) ? 
                                    CustomColor.white :
                                    CustomColor.black,
                        width: fnGetDeviceWidth(context),
                        onPressed: () async {
                          if(myPetUpdateFeedTimeSelectModeState != 'Y') {
                            await showDialog<void>(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return CustomTimePickerDialog(feedTimeIndex: i,);
                              },
                            );
                            return;
                          }
                          
                          if(myPetUpdateFeedTimeSelectModeState == 'Y') {
                            if(myPetUpdateFeedTimeDeleteListState.contains(i)) {
                              ref.read(myPetAddFeedTimeDeleteListProvider.notifier).remove(i);
                            } else {
                              ref.read(myPetAddFeedTimeDeleteListProvider.notifier).add(i);
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 5,),
                      ],
                    ),
                  DefaultTextButton(
                    // text: '${initialTime.hour < 12 ? '오전' : '오후'} ${initialTime.hour < 12 ? initialTime.hour : initialTime.hour - 12} : ${initialTime.minute}', 
                    text: '급여 시간 추가 +',
                    disabled: false,
                    borderColor: CustomColor.gray04,
                    backgroundColor: CustomColor.white,
                    width: fnGetDeviceWidth(context),
                    onPressed: () async {
                      if(myPetUpdateFeedTimeListState.length >= 3) {
                        showAlertDialog(
                          context: context, 
                          middleText: "사료 급여 시간은\n최대 3개까지만 추가 가능합니다."
                        );
                      } else {
                        ref.read(myPetAddFeedTimeMeridiemButtonProvider.notifier).set("");

                        await showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return const CustomTimePickerDialog();
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '현재 사료 급여 정보',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 5,),
                  for(int i=0; i<leftoverFeed.length;i++)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: DefaultTextButton(
                        text: '현재 ${leftoverFeed[i]} 남았어요', 
                        disabled: false,
                        borderColor: myPetUpdateFeedAmountButtonState == foodRemainGradeCode[i] 
                          ? CustomColor.yellow03 
                          : CustomColor.gray04,
                        backgroundColor: myPetUpdateFeedAmountButtonState == foodRemainGradeCode[i]
                          ? CustomColor.yellow03 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context),
                        onPressed: () {
                          ref.read(myPetAddFeedAmountButtonProvider.notifier).set(foodRemainGradeCode[i]);

                          ref.read(requestUpdateDogProvider.notifier).setFoodRemainGrade(foodRemainGradeCode[i]);

                          ref.read(myPetUpdateButtonProvider.notifier)
                             .activate(requestUpdateDogState);
                        },
                      ),
                    ),
                  const SizedBox(height: 16,),
                  const Text(
                    '반려동물 생년월일',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 8,),
                  OutlinedInput(
                    controller: petBirthInputController,
                    onChanged: (String petBirth) {
                      ref.read(requestUpdateDogProvider.notifier).setPetBirth(petBirthInputController.text);

                      fnCheckPetBirth(petBirthInputController.text);

                      ref.read(myPetUpdateButtonProvider.notifier)
                         .activate(requestUpdateDogState);
                    },
                    hintText: 'YYYY-MM-DD',
                    keyboardType: TextInputType.number,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                      BirthInputFormatter(),
                    ],
                    enabledBorder: myPetUpdateBirthInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      myPetUpdateBirthInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                        CustomColor.negative :
                        CustomColor.gray04,
                    focusedBorder: myPetUpdateBirthInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      myPetUpdateBirthInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                        CustomColor.negative :
                        CustomColor.gray04,
                  ),
                  Visibility(
                    visible: myPetUpdateBirthInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                             myPetUpdateBirthInputStatusCodeState != ProjectConstant.INPUT_SUCCESS,
                    child: Column(
                      children: [
                        const SizedBox(height: 4,),
                        Text(
                          myPetUpdateBirthInputStatusCodeState == ProjectConstant.INPUT_ERR_EMPTY ?
                            Sentence.PET_BIRTH_ERR_EMPTY :
                              myPetUpdateBirthInputStatusCodeState == ProjectConstant.INPUT_ERR_LENGTH ?
                                Sentence.PET_BIRTH_ERR_LENGTH :
                                  myPetUpdateBirthInputStatusCodeState == ProjectConstant.INPUT_ERR_FORMAT ?
                                    Sentence.PET_BIRTH_ERR_FORMAT :
                                      "",
                          style: CustomText.caption3.copyWith(
                            color: CustomColor.negative,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32,),
                  DefaultTextButton(
                    text: '수정하기', 
                    onPressed: () async {
                      await fnMyPetUpdateExec(widget.pet_id);
                    },
                    disabled: false,
                    borderColor: myPetUpdateButtonState 
                      ? CustomColor.yellow03 
                      : CustomColor.gray04,
                    backgroundColor: myPetUpdateButtonState
                      ? CustomColor.yellow03 
                      : CustomColor.gray04,
                  ),
                  const SizedBox(height: 16,),
                  DefaultTextButton(
                    text: '삭제하기', 
                    onPressed: () async {
                      showConfirmDialog(
                        context: context, 
                        middleText: "삭제하실 경우 다시는 볼 수 없어요 :(\n그래도 삭제하실건가요? :울다:", 
                        onConfirm: () async {
                          await fnMyPetDeleteExec(widget.pet_id);
                        },
                        confirmBackgroundColor: CustomColor.negative,
                      );
                    },
                    disabled: false,
                    borderColor: const Color(0xFFE60012),
                    backgroundColor: const Color(0xFFE60012),
                    textColor: CustomColor.white,
                  ),
                  const SizedBox(height: 32,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}