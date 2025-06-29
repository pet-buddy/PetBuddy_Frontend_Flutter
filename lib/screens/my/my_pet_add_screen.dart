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

class MyPetAddScreen extends ConsumerStatefulWidget {
  const MyPetAddScreen({super.key,});

  @override
  ConsumerState<MyPetAddScreen> createState() => MyPetAddScreenState();
}

class MyPetAddScreenState extends ConsumerState<MyPetAddScreen> with MyController {

  @override
  void initState() {
    super.initState();
    fnInitMyController(ref, context);
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fnInitMyPetAddState();
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
    final myPetAddTypeFilterState = ref.watch(myPetAddTypeFilterProvider);
    final myPetAddTypeDropdownState = ref.watch(myPetAddTypeDropdownProvider);
    final myPetAddFeedFilterState = ref.watch(myPetAddFeedFilterProvider);
    final myPetAddFeedDropdownState = ref.watch(myPetAddFeedDropdownProvider);
    final myPetAddSizeButtonState = ref.watch(myPetAddSizeButtonProvider);
    final myPetAddGenderButtonState = ref.watch(myPetAddGenderButtonProvider);
    final myPetAddNeuterButtonState = ref.watch(myPetAddNeuterButtonProvider);
    final myPetAddFeedAmountButtonState = ref.watch(myPetAddFeedAmountButtonProvider);
    final myPetAddNameInputStatusCodeState = ref.watch(myPetAddNameInputStatusCodeProvider);
    final myPetAddBirthInputStatusCodeState = ref.watch(myPetAddBirthInputStatusCodeProvider);
    final myPetAddButtonState = ref.watch(myPetAddButtonProvider);
    final requestNewDogState = ref.watch(requestNewDogProvider);
    final myPetAddFeedTimeListState = ref.watch(myPetAddFeedTimeListProvider);
    final myPetAddFeedTimeDeleteListState = ref.watch(myPetAddFeedTimeDeleteListProvider);
    final myPetAddFeedTimeSelectModeState = ref.watch(myPetAddFeedTimeSelectModeProvider);
    
    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '반려동물 추가하기',
        leadingOnPressed: () {
          if(!context.mounted) return;
          fnInvalidateMyPetAddState();
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
          fnInvalidateMyPetAddState();
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
                      ref.read(requestNewDogProvider.notifier).setPetName(petName);

                      fnCheckPetName(petName);

                      ref.read(myPetAddButtonProvider.notifier)
                          .activate(requestNewDogState);
                    },
                    keyboardType: TextInputType.text,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    enabledBorder: myPetAddNameInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      myPetAddNameInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                      CustomColor.negative :
                      CustomColor.gray04,
                    focusedBorder: myPetAddNameInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      myPetAddNameInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                      CustomColor.negative :
                      CustomColor.gray04,
                  ),
                  Visibility(
                    visible: myPetAddNameInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                             myPetAddNameInputStatusCodeState != ProjectConstant.INPUT_SUCCESS,
                    child: Column(
                      children: [
                        const SizedBox(height: 4,),
                        Text(
                          myPetAddNameInputStatusCodeState == ProjectConstant.INPUT_ERR_EMPTY ?
                            Sentence.PET_NAME_ERR_EMPTY :
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
                        borderColor: myPetAddSizeButtonState == smallSize 
                          ? CustomColor.yellow03 
                          : CustomColor.gray04,
                        backgroundColor: myPetAddSizeButtonState == smallSize 
                          ? CustomColor.yellow03 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.3,
                        onPressed: () {
                          ref.read(myPetAddSizeButtonProvider.notifier).set(smallSize); // 화면 업데이트
                          ref.read(requestNewDogProvider.notifier).setPetSize(smallSize); // 데이터 저장

                          ref.read(myPetAddButtonProvider.notifier)
                             .activate(requestNewDogState); // 추가하기 버튼 활성화 여부
                        },
                      ),
                      DefaultTextButton(
                        text: '중형', 
                        disabled: false,
                        borderColor: myPetAddSizeButtonState == mediumSize 
                          ? CustomColor.yellow03 
                          : CustomColor.gray04,
                        backgroundColor: myPetAddSizeButtonState == mediumSize 
                          ? CustomColor.yellow03 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.3,
                        onPressed: () {
                          ref.read(myPetAddSizeButtonProvider.notifier).set(mediumSize);
                          ref.read(requestNewDogProvider.notifier).setPetSize(mediumSize); // 데이터 저장

                          ref.read(myPetAddButtonProvider.notifier)
                             .activate(requestNewDogState);
                        },
                      ),
                      DefaultTextButton(
                        text: '대형', 
                        disabled: false,
                        borderColor: myPetAddSizeButtonState == largeSize 
                          ? CustomColor.yellow03 
                          : CustomColor.gray04,
                        backgroundColor: myPetAddSizeButtonState == largeSize 
                          ? CustomColor.yellow03 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.3,
                        onPressed: () {
                          ref.read(myPetAddSizeButtonProvider.notifier).set(largeSize);
                          ref.read(requestNewDogProvider.notifier).setPetSize(largeSize); // 데이터 저장

                          ref.read(myPetAddButtonProvider.notifier)
                             .activate(requestNewDogState);
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
                      fnGetFilteredPetTypeItems(petName);
                    },
                    keyboardType: TextInputType.text,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    hintText: '품종 검색',
                    suffixIcon: IconButton(
                      onPressed: () {
                        !myPetAddTypeDropdownState ?
                          fnGetAllPetTypeItems() :
                          ref.read(myPetAddTypeDropdownProvider.notifier).set(!myPetAddTypeDropdownState);
                      }, 
                      icon: SvgPicture.asset(
                        'assets/icons/organization/search.svg',
                      ),
                    ),
                  ),
                  if (myPetAddTypeDropdownState && myPetAddTypeFilterState.isNotEmpty)
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
                            children: myPetAddTypeFilterState.map((item) {
                              return ListTile(
                                title: Text(item),
                                onTap: () { 
                                  fnSelectPetTypeItems(item);

                                  ref.read(myPetAddButtonProvider.notifier)
                                     .activate(requestNewDogState);
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
                        borderColor: myPetAddGenderButtonState == femaleCode 
                          ? CustomColor.yellow03 
                          : CustomColor.gray04,
                        backgroundColor: myPetAddGenderButtonState == femaleCode 
                          ? CustomColor.yellow03 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
                          ref.read(myPetAddGenderButtonProvider.notifier).set(femaleCode);
                          ref.read(requestNewDogProvider.notifier).setPetGender(femaleCode); // 데이터 저장

                          ref.read(myPetAddButtonProvider.notifier)
                             .activate(requestNewDogState);
                        },
                      ),
                      DefaultTextButton(
                        text: '남아', 
                        disabled: false,
                        borderColor: myPetAddGenderButtonState == maleCode 
                          ? CustomColor.yellow03 
                          : CustomColor.gray04,
                        backgroundColor: myPetAddGenderButtonState == maleCode 
                          ? CustomColor.yellow03 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
                          ref.read(myPetAddGenderButtonProvider.notifier).set(maleCode);
                          ref.read(requestNewDogProvider.notifier).setPetGender(maleCode); // 데이터 저장

                          ref.read(myPetAddButtonProvider.notifier)
                             .activate(requestNewDogState);
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
                        borderColor: myPetAddNeuterButtonState == neuterN 
                          ? CustomColor.yellow03 
                          : CustomColor.gray04,
                        backgroundColor: myPetAddNeuterButtonState == neuterN 
                          ? CustomColor.yellow03 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
                          ref.read(myPetAddNeuterButtonProvider.notifier).set(neuterN);
                          ref.read(requestNewDogProvider.notifier).setNeuterYn(false); // 데이터 저장

                          ref.read(myPetAddButtonProvider.notifier)
                             .activate(requestNewDogState);
                        },
                      ),
                      DefaultTextButton(
                        text: '중성화 완료', 
                        disabled: false,
                        borderColor: myPetAddNeuterButtonState == neuterY
                          ? CustomColor.yellow03 
                          : CustomColor.gray04,
                        backgroundColor: myPetAddNeuterButtonState == neuterY 
                          ? CustomColor.yellow03 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
                          ref.read(myPetAddNeuterButtonProvider.notifier).set(neuterY);
                          ref.read(requestNewDogProvider.notifier).setNeuterYn(true); // 데이터 저장

                          ref.read(myPetAddButtonProvider.notifier)
                             .activate(requestNewDogState);
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
                      fnGetFilteredPetFeedItems(feedName);
                    },
                    keyboardType: TextInputType.text,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    hintText: '사료 검색',
                    suffixIcon: IconButton(
                      onPressed: () {
                        !myPetAddFeedDropdownState ?
                          fnGetAllPetFeedItems() :
                          ref.read(myPetAddFeedDropdownProvider.notifier).set(!myPetAddFeedDropdownState);
                      }, 
                      icon: SvgPicture.asset(
                        'assets/icons/organization/search.svg',
                      ),
                    ),
                  ),
                  if (myPetAddFeedDropdownState && myPetAddFeedFilterState.isNotEmpty)
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
                            children: myPetAddFeedFilterState.map((item) {
                              return ListTile(
                                title: Text(item),
                                onTap: () { 
                                  fnSelectPetFeedItems(item);

                                  ref.read(myPetAddButtonProvider.notifier)
                                     .activate(requestNewDogState);
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
                                if(myPetAddFeedTimeListState.isEmpty) {
                                  showAlertDialog(
                                    context: context, 
                                    middleText: "선택할 사료 급여 시간이 없습니다.",
                                  );
                                  return;
                                }
                                if(myPetAddFeedTimeSelectModeState == 'Y') {
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
                                  color: myPetAddFeedTimeSelectModeState == 'Y' ?
                                    CustomColor.black :
                                    CustomColor.gray03,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // const SizedBox(width: 8,),
                            GestureDetector(
                              onTap: () async {
                                if(myPetAddFeedTimeSelectModeState != 'Y') {
                                  showAlertDialog(
                                    context: context, 
                                    middleText: "'선택'을 클릭하여 주세요."
                                  );
                                  return;
                                }
                                if(myPetAddFeedTimeSelectModeState == 'Y' && myPetAddFeedTimeDeleteListState.isEmpty) {
                                  showAlertDialog(
                                    context: context, 
                                    middleText: "삭제할 사료 급여 시간을 선택해주세요.",
                                  );
                                  return;
                                }

                                List<int> indices = [];
                                // 삭제 리스트에 있는 요소(인덱스)를 변수에 담기
                                for(int i=0;i<myPetAddFeedTimeDeleteListState.length;i++) {
                                  indices.add(myPetAddFeedTimeDeleteListState[i]);
                                }
                                // 급여 시간 리스트 삭제
                                ref.read(myPetAddFeedTimeListProvider.notifier).removeMultipleAt(indices);
                                // 삭제 리스트 초기화
                                ref.read(myPetAddFeedTimeDeleteListProvider.notifier).set([]);
                                // 사료 급여 시간 값 세팅
                                myRef.read(requestNewDogProvider.notifier).setFeedTime(
                                  myRef.read(myPetAddFeedTimeListProvider.notifier).get(),
                                );
                                // 추가하기 버튼 상태 체크
                                ref.read(myPetAddButtonProvider.notifier)
                                   .activate(requestNewDogState);
                              },
                              child: Text(
                                '삭제 -',
                                style: CustomText.body10.copyWith(
                                  color: myPetAddFeedTimeSelectModeState == 'Y' && myPetAddFeedTimeDeleteListState.isNotEmpty ?
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
                  for(int i=0;i<myPetAddFeedTimeListState.length;i++)
                    Column(
                      children: [
                        DefaultTextButton(
                        text: fnConvertTime24To12(myPetAddFeedTimeListState[i]),
                        disabled: false,
                        borderColor: myPetAddFeedTimeSelectModeState == 'Y' && myPetAddFeedTimeDeleteListState.contains(i) ? 
                                     CustomColor.negative : 
                                     CustomColor.gray04,
                        backgroundColor: myPetAddFeedTimeSelectModeState == 'Y' && myPetAddFeedTimeDeleteListState.contains(i) ?
                                          CustomColor.negative :
                                             myPetAddFeedTimeSelectModeState == 'Y'  ?
                                              CustomColor.gray04 : 
                                              CustomColor.white,
                        textColor: myPetAddFeedTimeSelectModeState == 'Y' && myPetAddFeedTimeDeleteListState.contains(i) ? 
                                    CustomColor.white :
                                    CustomColor.black,
                        width: fnGetDeviceWidth(context),
                        onPressed: () async {
                          if(myPetAddFeedTimeSelectModeState != 'Y') {
                            await showDialog<void>(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return CustomTimePickerDialog(feedTimeIndex: i,);
                              },
                            );
                            return;
                          }
                          
                          if(myPetAddFeedTimeSelectModeState == 'Y') {
                            if(myPetAddFeedTimeDeleteListState.contains(i)) {
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
                      if(myPetAddFeedTimeListState.length >= 3) {
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
                        borderColor: myPetAddFeedAmountButtonState == foodRemainGradeCode[i] 
                          ? CustomColor.yellow03 
                          : CustomColor.gray04,
                        backgroundColor: myPetAddFeedAmountButtonState == foodRemainGradeCode[i]
                          ? CustomColor.yellow03 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context),
                        onPressed: () {
                          ref.read(myPetAddFeedAmountButtonProvider.notifier).set(foodRemainGradeCode[i]);

                          ref.read(requestNewDogProvider.notifier).setFoodRemainGrade(foodRemainGradeCode[i]);

                          ref.read(myPetAddButtonProvider.notifier)
                             .activate(requestNewDogState);
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
                      ref.read(requestNewDogProvider.notifier).setPetBirth(petBirth);

                      fnCheckPetBirth(petBirth);

                      ref.read(myPetAddButtonProvider.notifier)
                         .activate(requestNewDogState);
                    },
                    hintText: 'YYYY-MM-DD',
                    keyboardType: TextInputType.number,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                      BirthInputFormatter(),
                    ],
                    enabledBorder: myPetAddBirthInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      myPetAddBirthInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                        CustomColor.negative :
                        CustomColor.gray04,
                    focusedBorder: myPetAddBirthInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      myPetAddBirthInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                        CustomColor.negative :
                        CustomColor.gray04,
                  ),
                  Visibility(
                    visible: myPetAddBirthInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                             myPetAddBirthInputStatusCodeState != ProjectConstant.INPUT_SUCCESS,
                    child: Column(
                      children: [
                        const SizedBox(height: 4,),
                        Text(
                          myPetAddBirthInputStatusCodeState == ProjectConstant.INPUT_ERR_EMPTY ?
                            Sentence.PET_BIRTH_ERR_EMPTY :
                              myPetAddBirthInputStatusCodeState == ProjectConstant.INPUT_ERR_LENGTH ?
                                Sentence.PET_BIRTH_ERR_LEN :
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
                    text: '추가하기', 
                    onPressed: () async {
                      await fnMyPetAddExec();
                    },
                    disabled: false,
                    borderColor: myPetAddButtonState 
                      ? CustomColor.yellow03 
                      : CustomColor.gray04,
                    backgroundColor: myPetAddButtonState
                      ? CustomColor.yellow03 
                      : CustomColor.gray04,
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