import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_color.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_text.dart';
import 'package:petbuddy_frontend_flutter/common/utils/fn_get_device_width.dart';
import 'package:petbuddy_frontend_flutter/common/widget/line/divided_line.dart';
import 'package:petbuddy_frontend_flutter/controller/my_controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/my_pet_add_button_provider.dart';
import 'package:petbuddy_frontend_flutter/data/provider/my_pet_add_feed_time_list_provider.dart';
import 'package:petbuddy_frontend_flutter/data/provider/my_pet_add_feed_time_meridiem_button_provider.dart';
import 'package:petbuddy_frontend_flutter/data/provider/request_new_dog_provider.dart';

// ignore: must_be_immutable
class CustomTimePickerDialog extends ConsumerStatefulWidget {
  const CustomTimePickerDialog({
    super.key,
    this.feedTimeIndex = -1,
  });

  final int feedTimeIndex;

  @override
  ConsumerState<CustomTimePickerDialog> createState() => _CustomTimePickerDialog();
}

class _CustomTimePickerDialog extends ConsumerState<CustomTimePickerDialog> with MyController {

  TextEditingController hourController = TextEditingController(text: '');
  TextEditingController minuteController = TextEditingController(text: '');
  
  @override
  void initState() {
    super.initState();
    fnInitMyController(ref, context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // debugPrint(widget.feedTimeIndex.toString());
      // 수정할 때 시간 세팅
      if(widget.feedTimeIndex != -1) {
        String feedTime = fnConvertTime24To12(ref.read(myPetAddFeedTimeListProvider.notifier).get()[widget.feedTimeIndex]);

        // 오전/오후 세팅
        ref.read(myPetAddFeedTimeMeridiemButtonProvider.notifier).set(
          feedTime.substring(0,2) == '오전' ? 'AM' : 'PM',
        );

        // 시간 세팅
        hourController.text = feedTime.substring(3,5);
        minuteController.text = feedTime.substring(6,8);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final myPetAddFeedTimeListState = ref.watch(myPetAddFeedTimeListProvider);
    final myPetAddFeedTimeMeridiemButtonState = ref.watch(myPetAddFeedTimeMeridiemButtonProvider);
    final requestNewDogState = ref.watch(requestNewDogProvider);
    
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: CustomColor.white,
        child: Container(
          height: 251,
          constraints: BoxConstraints(
            maxWidth: fnGetDeviceWidth(context),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '사료 급여 시간 입력',
                            style: CustomText.body8,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 오전, 오후
                          meridiemSelectContainer(ref),
                          // 시간
                          timeInputContainer(ref, context, hourController),
                          // :
                          SizedBox(
                            width: 16,
                            height: 81,
                            child: Center(
                              child: Text(
                                ':',
                                style: CustomText.body1.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // 분
                          timeInputContainer(ref, context, minuteController),
                        ],
                      ),
                      const SizedBox(height: 16,),
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                color: CustomColor.gray04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CustomColor.white,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16)),
                      ),
                      height: 50,
                      child: InkWell(
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16)),
                        onTap: () {
                          fnInvalidateCustomTimePickerDialogState();
                          context.pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "닫기",
                              style: CustomText.body10.copyWith(
                                color:CustomColor.gray01,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CustomColor.blue04,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(16)),
                      ),
                      height: 50,
                      child: InkWell(
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(16)),
                        onTap: () {
                          if(!fnCheckTimeBeforeConvert(myPetAddFeedTimeMeridiemButtonState, hourController.text, minuteController.text)) return;

                          if(widget.feedTimeIndex != -1) {
                            // 급여 시간 수정
                            ref.read(myPetAddFeedTimeListProvider.notifier).updateAt(
                              widget.feedTimeIndex, 
                              fnConvertTime12To24(myPetAddFeedTimeMeridiemButtonState, hourController.text, minuteController.text),
                            );
                          } else {
                            // 급여 시간 추가
                            ref.read(myPetAddFeedTimeListProvider.notifier).add(
                              fnConvertTime12To24(myPetAddFeedTimeMeridiemButtonState, hourController.text, minuteController.text)
                            );
                            // 사료 급여 시간 값 세팅
                            myRef.read(requestNewDogProvider.notifier).setFeedTime(
                              myRef.read(myPetAddFeedTimeListProvider.notifier).get(),
                            );
                            // 반려동물 추가하기 화면의 추가하기 버튼 상태 체크
                            ref.read(myPetAddButtonProvider.notifier)
                                .activate(requestNewDogState);
                          }

                          fnInvalidateCustomTimePickerDialogState();
                          context.pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "확인",
                              style: CustomText.body10.copyWith(
                                color: CustomColor.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}

Widget timeInputContainer(WidgetRef ref, BuildContext context, TextEditingController controller) {
  return Container(
    width: (fnGetDeviceWidth(context) * 0.8 - 144) / 2,
    height: 81,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: CustomColor.gray05,
      borderRadius: BorderRadius.circular(12),
    ),
    alignment: Alignment.center,
    child: TextField(
      controller: controller,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      keyboardType: TextInputType.number,
      maxLength: 2,
      decoration: const InputDecoration(
        border: InputBorder.none,
        counterText: '', // 글자 수 카운터 제거
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) {
        if (value.isNotEmpty && int.tryParse(value) != null) {

        }
      },
    ),
  );
}

Widget meridiemSelectContainer(WidgetRef ref) {
  final myPetAddFeedTimeMeridiemButtonState = ref.watch(myPetAddFeedTimeMeridiemButtonProvider);

  return Container(
    width: 60,
    height: 81,
    decoration: BoxDecoration(
      border: Border.all(color: CustomColor.gray04),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    alignment: Alignment.center,
    child: Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              ref.read(myPetAddFeedTimeMeridiemButtonProvider.notifier).set('AM');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8),),
                color: myPetAddFeedTimeMeridiemButtonState == 'AM' ? 
                CustomColor.yellow03 :
                CustomColor.white,
              ),
              child: const Center(
                child: Text(
                  '오전',
                  style: CustomText.body10,
                ),
              ),
            ),
          ),
        ),
        const DividedLine(),
        Expanded(
          child: GestureDetector(
            onTap: () {
              ref.read(myPetAddFeedTimeMeridiemButtonProvider.notifier).set('PM');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8),),
                color: myPetAddFeedTimeMeridiemButtonState == 'PM' ? 
                CustomColor.yellow03 :
                CustomColor.white,
              ),
              child: const Center(
                child: Text(
                  '오후',
                  style: CustomText.body10,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
