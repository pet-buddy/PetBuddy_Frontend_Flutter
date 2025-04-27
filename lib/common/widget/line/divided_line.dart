import 'package:flutter/material.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';

class DividedLine extends StatelessWidget {
  const DividedLine({
    super.key,
    this.lineHeight,
    this.lineColor,
  });

  final double? lineHeight;
  final Color? lineColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: lineHeight ?? 1,
      decoration: BoxDecoration(
        color: lineColor ?? CustomColor.gray05,
      ),
    );
  }
}
