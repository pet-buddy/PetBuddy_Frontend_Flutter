import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';

class HomeHealthContainer extends StatelessWidget {
  const HomeHealthContainer({
    super.key,
    this.titleColor,
    required this.title,
    this.svgPicture,
    required this.child,
    this.onPressed,
  });

  final Color? titleColor;
  final String title;
  final SvgPicture? svgPicture;
  final Widget child;
  final VoidCallback? onPressed;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 32) / 2 - 16,
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(
        minHeight: 116,
        maxHeight: 150
      ),
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: const BorderRadius.all(Radius.circular(12),),
        boxShadow: [
          BoxShadow(
            color: CustomColor.gray04..withValues(alpha: 0.0),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 0),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: titleColor ?? CustomColor.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12),),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: svgPicture ?? const SizedBox(),
                ),
              ),
              const SizedBox(width: 8,),
              Text(
                title,
                style: CustomText.body9,
              )
            ],
          ),
          const SizedBox(height: 8,),
          Container(
            height: 1,
            color: CustomColor.gray05,
          ),
          const SizedBox(height: 8,),
          const Spacer(),
          child,
          const Spacer(),
        ],
      )
    );
  }
}
