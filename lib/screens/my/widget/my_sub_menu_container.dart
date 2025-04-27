import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';

class MySubMenuContainer extends StatelessWidget {
  const MySubMenuContainer({
    super.key,
    required this.menuName,
    required this.svgPath,
    required this.svgFlag,
    this.widget,
    required this.voidCallback,
  });

  final String menuName;
  final String svgPath;
  final bool svgFlag;
  final Widget? widget;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomColor.white,
      child: InkWell(
        onTap: voidCallback,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 56,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  menuName,
                  style: CustomText.body10.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                svgFlag
                    ? SvgPicture.asset(
                        svgPath,
                        width: 20,
                        height: 20,
                      )
                    : widget ?? const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
