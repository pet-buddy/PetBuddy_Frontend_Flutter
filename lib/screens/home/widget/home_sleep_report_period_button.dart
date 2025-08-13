import 'package:flutter/material.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';

class HomeSleepReportPeriodButton extends StatelessWidget {
  const HomeSleepReportPeriodButton({
    super.key,
    required this.width,
    required this.backgroundColor,
    required this.text,
    required this.textColor,
    required this.onPressed,
  });

  final double width; 
  final Color backgroundColor; 
  final String text; 
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 28,
        alignment: Alignment.center,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(20),),
        ),
        child: Text(
          text,
          style: CustomText.caption3.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
