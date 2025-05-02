import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_color.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_text.dart';
import 'package:petbuddy_frontend_flutter/common/utils/fn_get_device_width.dart';
import 'package:petbuddy_frontend_flutter/common/widget/line/divided_line.dart';
import 'package:petbuddy_frontend_flutter/controller/my_controller.dart';

class CustomTimePickerDialog extends ConsumerStatefulWidget {
  const CustomTimePickerDialog({
    super.key,
  });

  @override
  ConsumerState<CustomTimePickerDialog> createState() => _CustomTimePickerDialog();
}

class _CustomTimePickerDialog extends ConsumerState<CustomTimePickerDialog> with MyController {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 현재 시간 세팅
    });
  }

  TextEditingController hourController = TextEditingController(text: '29');
  TextEditingController minuteController = TextEditingController(text: '29');

  @override
  Widget build(BuildContext context) {
    
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
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
                          _periodSelectContainer(ref),
                          // 시간
                          _timeInputContainer(ref, context, hourController),
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
                          _timeInputContainer(ref, context, minuteController),
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
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16)),
                      ),
                      height: 50,
                      child: InkWell(
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16)),
                        onTap: () {
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

Widget _timeInputContainer(WidgetRef ref, BuildContext context, TextEditingController controller) {
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
      // controller: minuteController,
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

Widget _periodSelectContainer(WidgetRef ref) {
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
          
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8),),
                color: CustomColor.white,
              ),
              child: Center(
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
          
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8),),
                color: CustomColor.white,
              ),
              child: Center(
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
