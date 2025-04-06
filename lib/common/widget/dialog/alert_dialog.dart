import 'package:petbuddy_frontend_flutter/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

showAlertDialog({
  required BuildContext context,
  required String middleText,
  VoidCallback? onConfirm,
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 261,
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
                          style: CustomText.body8,
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
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: const BoxDecoration(
                  color: CustomColor.blue02,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16), 
                    bottomRight: Radius.circular(16)
                  ),
                ),
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  onTap: () {
                    context.pop();
                    onConfirm != null ? onConfirm() : null;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "닫기",
                        style: CustomText.body11.copyWith(
                          color: CustomColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  });
}