
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
    this.width,
    this.height,
  });

  final String text;
  final bool disabled;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled ? CustomColor.gray04 : backgroundColor,
          side: BorderSide(
            width: 1,
            color: disabled ? CustomColor.gray04 : borderColor ?? CustomColor.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          overlayColor: CustomColor.gray04,
        ),
        child: Text(
          text,
          style: CustomText.caption2.copyWith(
            fontWeight: FontWeight.bold,
            color: disabled ? CustomColor.gray03 : textColor
          )
        ),
      ),
    );
  }
}
