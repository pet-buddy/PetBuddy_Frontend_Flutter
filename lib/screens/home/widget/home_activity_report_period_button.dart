import 'package:flutter/material.dart';

class HomeActivityReportPeriodButton extends StatelessWidget {
  const HomeActivityReportPeriodButton({
    super.key,
    required this.width,
    required this.color,
    required this.text,
    required this.onPressed,
  });

  final double width; 
  final Color color; 
  final String text; 
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(8),),
        ),
        child: Text(
          text
        ),
      ),
    );
  }
}
