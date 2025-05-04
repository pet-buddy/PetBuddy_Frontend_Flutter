
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    this.disabled = true,
    this.onPressed,
    required this.text,
    this.backgroundColor = CustomColor.white,
    this.borderColor = CustomColor.white,
    this.textColor = CustomColor.black,
    this.svgPicture,
    this.imgAsset,
    this.rightPairBox,
  });

  final String text;
  final bool disabled;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final SvgPicture? svgPicture;
  final Image? imgAsset;
  final SizedBox? rightPairBox;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled ? CustomColor.gray04 : backgroundColor ?? CustomColor.yellow03,
          side: BorderSide(
            width: 1,
            color: disabled ? CustomColor.gray04 : borderColor ?? CustomColor.yellow03,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 36.0 - (svgPicture != null ? svgPicture?.width : imgAsset != null ? imgAsset?.width : 36)!.toDouble(),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 36,
                    maxHeight: 29,
                  ),
                  child: svgPicture ?? imgAsset ?? const SizedBox(width: 25,)
                ),
              ],
            ),
            Text(
              text,
              style: CustomText.caption2.copyWith(
                fontWeight: FontWeight.bold,
                color: disabled ? CustomColor.gray03 : textColor ?? CustomColor.black
              )
            ),
            rightPairBox ?? const SizedBox(width: 25,)
          ],
        )
      ),
    );
  }
}
