import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter, LengthLimitingTextInputFormatter;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';

class MyProfileUpdateScreen extends ConsumerStatefulWidget {
  const MyProfileUpdateScreen({super.key});

  @override
  ConsumerState<MyProfileUpdateScreen> createState() => MyProfileUpdateScreenState();
}

class MyProfileUpdateScreenState extends ConsumerState<MyProfileUpdateScreen> with MyController {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '계정 정보 수정',
        leadingOnPressed: () {
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
                        borderColor: CustomColor.gray04,
                        backgroundColor: CustomColor.white,
                        width: MediaQuery.of(context).size.width * 0.42,
                        onPressed: () {
                      
                        },
                      ),
                      const Spacer(),
                      DefaultTextButton(
                        text: '남자', 
                        disabled: false,
                        borderColor: CustomColor.gray04,
                        backgroundColor: CustomColor.white,
                        width: MediaQuery.of(context).size.width * 0.42,
                        onPressed: () {
                      
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
                  const SizedBox(height: 16,),
                  const Text(
                    '관심있는 건강정보',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 8,),
                  // TODO : drop down
                  const SizedBox(height: 16,),
                  const Text(
                    '휴대전화번호',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 8,),
                  OutlinedInput(
                    // controller: ,
                    onChanged: (String tel) {
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 50 - 100 - 500,
                  ),
                  DefaultTextButton(
                    text: '수정하기', 
                    onPressed: () {

                    },
                  ),
                  const SizedBox(height: 75,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}