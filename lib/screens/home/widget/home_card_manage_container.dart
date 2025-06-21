import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';
import 'package:petbuddy_frontend_flutter/common/utils/fn_get_device_width.dart';

class HomeCardManageContainer extends StatelessWidget {
  const HomeCardManageContainer({
    super.key,
    this.thumbnailColor,
    required this.title,
    this.thumbnailPicture,
    required this.child,
    this.onPressed,
    this.disabled,
  });

  final Color? thumbnailColor;
  final String title;
  final SvgPicture? thumbnailPicture;
  final Widget child;
  final VoidCallback? onPressed;
  final bool? disabled;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed != null ? onPressed!() : null;
      },
      child: Container(
        width: (fnGetDeviceWidth(context) - 32) / 2 - 8,
        constraints: const BoxConstraints(
          minHeight: 99,
          maxHeight: 120
        ),
        decoration: BoxDecoration(
          color: CustomColor.white,
          borderRadius: const BorderRadius.all(Radius.circular(24),),
          boxShadow: [
            BoxShadow(
              color: CustomColor.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: thumbnailColor ?? CustomColor.white,
                          borderRadius: const BorderRadius.all(Radius.circular(24),),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: thumbnailPicture ?? const SizedBox(),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Text(
                        title,
                        style: CustomText.body7,
                      )
                    ],
                  ),
                  const Spacer(),
                  child,
                  const Spacer(),
                ],
              ),
            ),
            (disabled ?? false) ? 
              ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  width: (fnGetDeviceWidth(context) - 32) / 2 - 8,
                  constraints: const BoxConstraints(
                    minHeight: 99,
                    maxHeight: 120
                  ),
                  color: CustomColor.white.withValues(alpha: 0.2),
                ),
              ),
            ) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
