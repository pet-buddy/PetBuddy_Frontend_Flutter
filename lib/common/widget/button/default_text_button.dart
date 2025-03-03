
import 'package:flutter/material.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';

class DefaultTextButton extends StatelessWidget {
  const DefaultTextButton({
    super.key,
    this.disabled = true,
    this.onPressed,
    required this.text,
    this.backgroundColor = CustomColor.white,
    this.borderColor = CustomColor.white,
    this.textColor = CustomColor.black,
  });

  final String text;
  final bool disabled;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled ? CustomColor.lightGray : backgroundColor,
          side: BorderSide(
            width: 1,
            color: disabled ? CustomColor.lightGray : borderColor ?? CustomColor.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: CustomText.body2.copyWith(
            color: disabled ? CustomColor.extraLightGray : textColor
          )
        ),
      ),
    );
  }
}
