import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter, LengthLimitingTextInputFormatter;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';

class MyProfileUpdateScreen extends ConsumerStatefulWidget {
  const MyProfileUpdateScreen({super.key});

  @override
  ConsumerState<MyProfileUpdateScreen> createState() => MyProfileUpdateScreenState();
}

class MyProfileUpdateScreenState extends ConsumerState<MyProfileUpdateScreen> with MyController {

  @override
  void initState() {
    super.initState();
    fnInitMyController(ref, context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fnInitMyProfileUpdateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final myProfileGenderButtonState = ref.watch(myProfileGenderButtonProvider);
    final myProfileInterestButtonState = ref.watch(myProfileInterestButtonProvider);
    final myProfileUpdateButtonState = ref.watch(myProfileUpdateButtonProvider);
    final myProfileInputState = ref.watch(myProfileInputProvider);

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '계정 정보 수정',
        leadingOnPressed: () {
          // 해당 화면 벗어날 경우 관련 Provider 초기화
          fnInvalidateMyProfileUpdateState();
          // 뒤로가기
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
          fnInvalidateMyProfileUpdateState();
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
                  const SizedBox(height: 16,),
                  const Text(
                    '성별',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextButton(
                        text: '여자', 
                        disabled: false,
                        borderColor: myProfileGenderButtonState == femaleCode 
                          ? CustomColor.yellow03 
                          : CustomColor.gray04,
                        backgroundColor: myProfileGenderButtonState == femaleCode 
                          ? CustomColor.yellow03 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
                          ref.read(myProfileGenderButtonProvider.notifier).set(femaleCode);

                          ref.read(myProfileInputProvider.notifier)
                              .setGender(femaleCode);

                          ref.read(myProfileUpdateButtonProvider.notifier)
                             .activate(myProfileInputState);
                        },
                      ),
                      // const Spacer(),
                      DefaultTextButton(
                        text: '남자', 
                        disabled: false,
                        borderColor: myProfileGenderButtonState == maleCode
                          ? CustomColor.yellow03 
                          : CustomColor.gray04,
                        backgroundColor: myProfileGenderButtonState == maleCode 
                          ? CustomColor.yellow03 
                          : CustomColor.white,
                        width: fnGetDeviceWidth(context) * 0.43,
                        onPressed: () {
                          ref.read(myProfileGenderButtonProvider.notifier).set(maleCode);

                          ref.read(myProfileInputProvider.notifier)
                              .setGender(maleCode);

                          ref.read(myProfileUpdateButtonProvider.notifier)
                             .activate(myProfileInputState);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  const Text(
                    '생년월일',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 8,),
                  OutlinedInput(
                    controller: birthInputController,
                    onChanged: (String birth) {
                      ref.read(myProfileInputProvider.notifier)
                         .setBirth(birthInputController.text);

                      ref.read(myProfileUpdateButtonProvider.notifier)
                         .activate(myProfileInputState);
                    },
                    hintText: 'YYYY-MM-DD',
                    keyboardType: TextInputType.number,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                      BirthInputFormatter(),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  const Text(
                    '관심있는 건강정보',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 8,),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      for(int i=0;i<interests.length;i++)
                        Container(
                          height: 40,
                          margin: const EdgeInsets.only(right: 16, bottom: 8),
                          child: DefaultTextButton(
                            text: interests[i]['text'].toString(), 
                            disabled: false,
                            borderColor: myProfileInterestButtonState == i 
                              ? CustomColor.yellow03
                              : CustomColor.gray04,
                            backgroundColor: myProfileInterestButtonState == i 
                              ? CustomColor.yellow03
                              : CustomColor.white,
                            width: double.parse(interests[i]['width'].toString()),
                            onPressed: () {
                              ref.read(myProfileInterestButtonProvider.notifier).set(i);

                              ref.read(myProfileInputProvider.notifier)
                                 .setInterest(interestCode[i]);

                              ref.read(myProfileUpdateButtonProvider.notifier)
                                 .activate(myProfileInputState);
                            },
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  const Text(
                    '휴대전화번호',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 8,),
                  OutlinedInput(
                    controller: phoneInputController,
                    onChanged: (String phone) {
                      ref.read(myProfileInputProvider.notifier)
                         .setPhoneNumber(phoneInputController.text);

                      ref.read(myProfileUpdateButtonProvider.notifier)
                         .activate(myProfileInputState);
                    },
                    hintText: '010-1234-5678',
                    keyboardType: TextInputType.number,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                      TelInputFormatter(),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  /* SizedBox(
                    height: MediaQuery.of(context).size.height > 641 ? 
                      MediaQuery.of(context).size.height - 641 :
                      0
                  ), */
                  const SizedBox(height: 16,),
                  DefaultTextButton(
                    text: '수정하기', 
                    onPressed: () async {
                      await fnMyProfileUpdateExec();
                    },
                    disabled: !myProfileUpdateButtonState,
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