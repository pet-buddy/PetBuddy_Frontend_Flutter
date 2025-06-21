import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends ConsumerState<RegisterScreen> with RegisterController {

  @override
  void initState() {
    super.initState();
    fnInitRegisterController(ref, context);
  }

  @override
  void dispose() {
    super.dispose();
    registerEmailInputController.dispose();
    registerPasswordInputController.dispose();
    registerPasswordConfirmInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerButtonState = ref.watch(registerButtonProvider);
    final registerEmailInputStatusCodeState = ref.watch(registerEmailInputStatusCodeProvider);
    final registerPwdInputStatusCodeState = ref.watch(registerPwdInputStatusCodeProvider);
    final registerPwdConfirmInputStatusCodeState = ref.watch(registerPwdConfirmInputStatusCodeProvider);

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '회원가입',
        leadingOnPressed: () {
          if(!context.mounted) return;
          context.pop();
          fnInvalidateRegisterState();
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
          fnInvalidateRegisterState();
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
                    controller: registerEmailInputController,
                    onChanged: (String email) {
                      ref.read(requestEmailRegisterProvider.notifier)
                         .setEmail(registerEmailInputController.text);

                      fnCheckRegisterEmail(email);
                    },
                    hintText: 'hello@email.com',
                    keyboardType: TextInputType.emailAddress,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    enabledBorder: registerEmailInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      registerEmailInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                        CustomColor.negative :
                        CustomColor.gray04,
                    focusedBorder: registerEmailInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      registerEmailInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                        CustomColor.negative :
                        CustomColor.gray04,
                  ),
                  Visibility(
                    visible: registerEmailInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                             registerEmailInputStatusCodeState != ProjectConstant.INPUT_SUCCESS,
                    child: Column(
                      children: [
                        const SizedBox(height: 4,),
                        Text(
                          registerEmailInputStatusCodeState == ProjectConstant.INPUT_ERR_EMPTY ?
                            Sentence.EMAIL_ERR_EMPTY :
                              registerEmailInputStatusCodeState == ProjectConstant.INPUT_ERR_FORMAT ?
                                Sentence.EMAIL_ERR_FORMAT :
                                  "",
                          style: CustomText.caption3.copyWith(
                            color: CustomColor.negative,
                          ),
                        ),
                      ],
                    )
                  ),
                  /* const SizedBox(height: 16),
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
                  ), */
                  const SizedBox(height: 16),
                  const Text(
                    '비밀번호',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 5,),
                  OutlinedInput(
                    controller: registerPasswordInputController,
                    onChanged: (String pwd) {
                      ref.read(requestEmailRegisterProvider.notifier)
                         .setPwd(registerPasswordInputController.text);

                      fnCheckRegisterPassword(pwd);
                    },
                    hintText: '비밀번호를 입력하세요',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    enabledBorder: registerPwdInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      registerPwdInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                      CustomColor.negative :
                      CustomColor.gray04,
                    focusedBorder: registerPwdInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      registerPwdInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                      CustomColor.negative :
                      CustomColor.gray04,
                  ),
                  Visibility(
                    visible: registerPwdInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                             registerPwdInputStatusCodeState != ProjectConstant.INPUT_SUCCESS,
                    child: Column(
                      children: [
                        const SizedBox(height: 4,),
                        Text(
                          registerPwdInputStatusCodeState == ProjectConstant.INPUT_ERR_EMPTY ?
                            Sentence.PWD_ERR_EMPTY :
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
                    '비밀번호 확인',
                    style: CustomText.body10,
                  ),
                  const SizedBox(height: 5,),
                  OutlinedInput(
                    controller: registerPasswordConfirmInputController,
                    onChanged: (String pwdConfirm) {
                      fnCheckRegisterPasswordConfirm(registerPasswordInputController.text, pwdConfirm);

                      ref.read(registerButtonProvider.notifier).activate(
                        registerEmailInputController.text, 
                        registerPasswordInputController.text,
                        registerPasswordConfirmInputController.text,
                      );
                    },
                    hintText: '비밀번호를 한 번 더 입력하세요',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    enabledBorder: registerPwdConfirmInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      registerPwdConfirmInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                      CustomColor.negative :
                      CustomColor.gray04,
                    focusedBorder: registerPwdConfirmInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                      registerPwdConfirmInputStatusCodeState != ProjectConstant.INPUT_SUCCESS  ? 
                      CustomColor.negative :
                      CustomColor.gray04,
                  ),
                  Visibility(
                    visible: registerPwdConfirmInputStatusCodeState != ProjectConstant.INPUT_INIT && 
                             registerPwdConfirmInputStatusCodeState != ProjectConstant.INPUT_SUCCESS,
                    child: Column(
                      children: [
                        const SizedBox(height: 4,),
                        Text(
                          registerPwdConfirmInputStatusCodeState == ProjectConstant.INPUT_ERR_EMPTY ?
                            Sentence.PWD_CONFIRM_ERR_EMPTY :
                              registerPwdConfirmInputStatusCodeState == ProjectConstant.INPUT_ERR_NOT_MATCHED ?
                                Sentence.PWD_ERR_NOT_MATCHED :
                                "",
                          style: CustomText.caption3.copyWith(
                            color: CustomColor.negative,
                          ),
                        ),
                      ],
                    )
                  ),
                  const SizedBox(height: 16),
                  DefaultTextButton(
                    text: '회원가입', 
                    onPressed: () async {
                      await fnEmailRegisterExec();
                    },
                    disabled: !registerButtonState,
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
