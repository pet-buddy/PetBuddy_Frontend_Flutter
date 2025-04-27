import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/my_pet_add_type_dropdown_provider.dart';
import 'package:petbuddy_frontend_flutter/data/provider/my_pet_add_type_filter_provider.dart';

class MyPetAddScreen extends ConsumerStatefulWidget {
  const MyPetAddScreen({super.key});

  @override
  ConsumerState<MyPetAddScreen> createState() => MyPetAddScreenState();
}

class MyPetAddScreenState extends ConsumerState<MyPetAddScreen> with MyController {

  @override
  void initState() {
    super.initState();
    fnInitMyController(ref, context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      
    });
  }

  @override
  void dispose() {
    super.dispose();
    petTypeInputController.dispose();
    petTypeScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myPetAddTypeFilterState = ref.watch(myPetAddTypeFilterProvider);
    final myPetAddTypeDropdownState = ref.watch(myPetAddTypeDropdownProvider);

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '반려동물 추가하기',
        leadingOnPressed: () {
          if(!context.mounted) return;
          fnInitMyPetAddState();
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
          fnInitMyPetAddState();
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
                    // controller: ,
                    onChanged: (String petName) {

                    },
                    keyboardType: TextInputType.text,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
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
                        backgroundColor: CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.3,
                        onPressed: () {
                        },
                      ),
                      DefaultTextButton(
                        text: '중형', 
                        disabled: false,
                        borderColor: CustomColor.gray04,
                        backgroundColor: CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.3,
                        onPressed: () {
                        },
                      ),
                      DefaultTextButton(
                        text: '대형', 
                        disabled: false,
                        borderColor: CustomColor.gray04,
                        backgroundColor: CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.3,
                        onPressed: () {
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
                    suffixIcon: IconButton(
                      onPressed: () {
                        fnGetAllPetTypeItems();
                      }, 
                      icon: SvgPicture.asset(
                        'assets/icons/organization/search.svg',
                      ),
                    ),
                  ),
                  // TODO : 품종검색
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
                                onTap: () => fnSelectPetTypeItems(item),
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
                        backgroundColor: CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
                        },
                      ),
                      DefaultTextButton(
                        text: '남아', 
                        disabled: false,
                        borderColor: CustomColor.gray04,
                        backgroundColor: CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
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
                        borderColor: CustomColor.gray04,
                        backgroundColor: CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
                        },
                      ),
                      DefaultTextButton(
                        text: '중성화 완료', 
                        disabled: false,
                        borderColor: CustomColor.gray04,
                        backgroundColor: CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
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
                  // TODO : 사료검색

                  const SizedBox(height: 16),
                  const Text(
                    '사료 급여 시간',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 5,),
                  // TODO : 사료검색

                  const SizedBox(height: 16),
                  const Text(
                    '현재 사료 급여 정보',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 5,),
                  // TODO : % 입력

                  const SizedBox(height: 16,),
                  const Text(
                    '반려동물 생년월일',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 8,),
                  OutlinedInput(
                    // controller: ,
                    onChanged: (String birth) {
                    },
                    hintText: 'YYYY / MM / DD',
                    keyboardType: TextInputType.number,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                      BirthInputFormatter(),
                    ],
                  ),
                  const SizedBox(height: 32,),
                  DefaultTextButton(
                    text: '추가하기', 
                    onPressed: () async {
                      
                    },
                    disabled: true,
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