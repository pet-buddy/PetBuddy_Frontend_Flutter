import 'package:petbuddy_frontend_flutter/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/utils/fn_get_device_width.dart';

showConfirmDialog({
  required BuildContext context,
  required String middleText,
  required VoidCallback onConfirm,
  Color? cancelTextColor,
  String? cancelText,
  Color? confirmTextColor,
  String? confirmText,
  bool barrierDismissible = true,
}) {
  showDialog(
    // useRootNavigator: false,
    barrierDismissible: barrierDismissible, // 바깥 영역 터치 시 -> true : 창닫기 O, false :  창닫기 X 
    context: context, 
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: CustomColor.white,
        child: Container(
          // width: (kIsWeb ? ProjectConstant.WEB_MAX_WIDTH : MediaQuery.of(context).size.width) * 0.8,
          height: 261,
          constraints: BoxConstraints(
            maxWidth: fnGetDeviceWidth(context),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 210,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          middleText,
                          style: CustomText.body11,
                          textAlign: TextAlign.center,
                        ),
                      ),
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
                    child: SizedBox(
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
                              cancelText ?? "닫기",
                              style: CustomText.body10.copyWith(
                                color: CustomColor.gray01,
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
                          onConfirm();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              confirmText ?? "확인",
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
  });
}