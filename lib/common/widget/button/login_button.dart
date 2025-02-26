
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
  });

  final String text;
  final bool disabled;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final SvgPicture? svgPicture;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(
            width: 1,
            color: borderColor ?? CustomColor.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 25,
              height: 25,
              child: svgPicture ?? const SizedBox(width: 0,),
            ),
            Text(
              text,
              style: CustomText.body2.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor
              )
            ),
            const SizedBox(
              width: 25,
              height: 25,
            ),
          ],
        )
      ),
    );
  }
}
