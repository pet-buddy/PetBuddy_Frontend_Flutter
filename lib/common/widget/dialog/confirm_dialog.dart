import 'package:petbuddy_frontend_flutter/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/utils/fn_get_device_width.dart';

showConfirmDialog({
  required BuildContext context,
  String? titleText,
  required String middleText,
  required VoidCallback onConfirm,
  Color? cancelBackgroundColor,
  Color? cancelTextColor,
  String? cancelText,
  Color? confirmBackgroundColor,
  Color? confirmTextColor,
  String? confirmText,
  bool barrierDismissible = true,
  double? height,
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
          height: height ?? 211, // 261,
          constraints: BoxConstraints(
            maxWidth: fnGetDeviceWidth(context),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: height != null ? height - 51 : 160, // 210,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      titleText != null ? Flexible(
                        child: Text(
                          titleText,
                          style: CustomText.body9,
                          textAlign: TextAlign.center,
                        ),
                      ) : const SizedBox(),
                      titleText != null ? 
                        const SizedBox(height: 8,) :
                        const SizedBox(),
                      Flexible(
                        child: Text(
                          middleText,
                          style: CustomText.body10.copyWith(
                            color: titleText != null ? 
                              CustomColor.gray03 :
                              CustomColor.black,
                          ),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: cancelBackgroundColor ?? CustomColor.white,
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
                              cancelText ?? "닫기",
                              style: CustomText.body10.copyWith(
                                color: cancelTextColor ?? CustomColor.gray01,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: confirmBackgroundColor ?? CustomColor.blue04,
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(16)),
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
                                color: confirmTextColor ?? CustomColor.white,
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