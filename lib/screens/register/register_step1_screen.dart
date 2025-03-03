import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';

class RegisterStep1Screen extends ConsumerStatefulWidget {
  const RegisterStep1Screen({super.key});

  @override
  ConsumerState<RegisterStep1Screen> createState() => RegisterStep1ScreenState();
}

class RegisterStep1ScreenState extends ConsumerState<RegisterStep1Screen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '회원가입',
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
                  const SizedBox(height: 32,),
                  const Text(
                    '이메일',
                    style: CustomText.body4,
                  ),
                  const SizedBox(height: 5,),
                  OutlinedInput(
                    // controller: emailInputController,
                    onChanged: (String email) {

                    },
                    hintText: 'hello@email.com',
                    keyboardType: TextInputType.emailAddress,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  const SizedBox(height: 16),
                  DefaultTextButton(
                    text: '인증번호 발송', 
                    onPressed: () {

                    },
                  ),
                  const SizedBox(height: 16),
                  OutlinedInput(
                    // controller: ,
                    onChanged: (String pwd) {
                    },
                    hintText: '인증번호 입력',
                    keyboardType: TextInputType.number,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  const SizedBox(height: 16),
                  DefaultTextButton(
                    text: '인증하기', 
                    onPressed: () {
                  
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '비밀번호',
                    style: CustomText.body4,
                  ),
                  const SizedBox(height: 5,),
                  OutlinedInput(
                    // controller: passwordInputController,
                    onChanged: (String pwd) {
                    },
                    hintText: '비밀번호를 입력하세요',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '비밀번호 확인',
                    style: CustomText.body4,
                  ),
                  const SizedBox(height: 5,),
                  OutlinedInput(
                    // controller: ,
                    onChanged: (String pwd) {
                    },
                    hintText: '비밀번호를 한 번 더 입력하세요',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  const SizedBox(height: 16),
                  DefaultTextButton(
                    text: '회원가입', 
                    onPressed: () {

                    },
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
