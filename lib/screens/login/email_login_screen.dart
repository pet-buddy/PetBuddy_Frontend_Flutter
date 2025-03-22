import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/login_controller.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';

class EmailLoginScreen extends ConsumerStatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  ConsumerState<EmailLoginScreen> createState() => EmailLoginScreenState();
}

class EmailLoginScreenState extends ConsumerState<EmailLoginScreen> with LoginController {

  @override
  void initState() {
    super.initState();
    fnInitLoginController(ref, context);
  }

  @override
  Widget build(BuildContext context) {
    final emailLoginButtonState = ref.watch(emailLoginButtonProvider);

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '이메일 로그인',
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
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 5,),
                  OutlinedInput(
                    controller: emailInputController,
                    onChanged: (String email) {
                      ref.read(emailLoginInputProvider.notifier)
                         .setEmail(emailInputController.text);
                    },
                    hintText: 'hello@email.com',
                    keyboardType: TextInputType.emailAddress,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '비밀번호',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 5,),
                  OutlinedInput(
                    controller: passwordInputController,
                    onChanged: (String pwd) {
                      ref.read(emailLoginInputProvider.notifier)
                         .setPwd(passwordInputController.text);

                      ref.read(emailLoginButtonProvider.notifier).activate(
                        emailInputController.text, 
                        passwordInputController.text
                      );
                    },
                    hintText: '비밀번호를 입력하세요',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  ),
                  const SizedBox(height: 16),
                  DefaultTextButton(
                    text: '로그인', 
                    onPressed: () async {
                      await fnEmailLoginExec();
                    },
                    disabled: !emailLoginButtonState,
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                        },
                        child: Text(
                          "비밀번호를 까먹으셨나요?",
                          style: CustomText.body11.copyWith(
                            color: CustomColor.gray03,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Container( 
                        height: 12,
                        width: 1,
                        color:CustomColor.gray03,
                      ),
                      const SizedBox(width: 16,),
                      InkWell(
                        onTap: () {
                          context.pushNamed('register_step1_screen');
                        },
                        child: Text(
                          "회원가입",
                          style: CustomText.body11.copyWith(
                            color: CustomColor.gray03,
                          ),
                        ),
                      ),
                    ],
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
