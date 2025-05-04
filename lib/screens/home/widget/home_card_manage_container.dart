import 'package:flutter/foundation.dart';
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
  });

  final Color? thumbnailColor;
  final String title;
  final SvgPicture? thumbnailPicture;
  final Widget child;
  final VoidCallback? onPressed;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed != null ? onPressed!() : null;
      },
      child: Container(
        width: (fnGetDeviceWidth(context) - 32) / 2 - 8,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        constraints: const BoxConstraints(
          minHeight: 99,
          maxHeight: 120
        ),
        decoration: BoxDecoration(
          color: CustomColor.white,
          borderRadius: const BorderRadius.all(Radius.circular(24),),
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
                    color: thumbnailColor ?? CustomColor.white,
                    borderRadius: const BorderRadius.all(Radius.circular(12),),
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
    );
  }
}
