
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';

class DefaultIconButton extends StatelessWidget {
  const DefaultIconButton({
    super.key,
    this.disabled = true,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.disalbedBackgroundColor,
    this.disalbedBorderColor,
    this.disalbedTextColor,
    this.width,
    this.height,
    this.elevation,
    this.borderRadius,
    this.svgPicture,
  });

  final String text;
  final bool disabled;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? disalbedBackgroundColor;
  final Color? disalbedBorderColor;
  final Color? disalbedTextColor;
  final double? width;
  final double? height;
  final double? elevation;
  final double? borderRadius;
  final SvgPicture? svgPicture;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 0,
          backgroundColor: disabled ? 
            (disalbedBackgroundColor ?? CustomColor.gray04) : 
            (backgroundColor ?? CustomColor.yellow03),
          side: BorderSide(
            width: 1,
            color: disabled ? 
              (disalbedBorderColor ?? CustomColor.gray04) : 
              (borderColor ?? CustomColor.yellow03),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16),
          ),
          overlayColor: CustomColor.gray04,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgPicture ?? const SizedBox(),
            svgPicture != null ? 
              const SizedBox(width: 16,) :
              const SizedBox(),
            Text(
              text,
              style: CustomText.caption2.copyWith(
                fontWeight: FontWeight.bold,
                color: disabled ? 
                  (disalbedTextColor ?? CustomColor.gray03) : 
                  (textColor ?? CustomColor.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
