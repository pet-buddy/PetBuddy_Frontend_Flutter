import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';
import 'package:flutter/foundation.dart';


class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    required this.title,
    this.leadingDisable = false,
    this.leadingOnPressed,
    this.actionDisable = false,
    this.actionOnPressed,
  });

  final String title;
  final bool leadingDisable;
  final VoidCallback? leadingOnPressed;
  final bool actionDisable;
  final VoidCallback? actionOnPressed;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      /* preferredSize: Size(
        kIsWeb ? 
          ProjectConstant.WEB_MAX_WIDTH : 
          MediaQuery.of(context).size.width
        , 50.0
      ), */
      preferredSize: const Size.fromHeight(50.0),
      child: AppBar(
        elevation: 0,
        backgroundColor: CustomColor.white,
        leading: !leadingDisable
            ? IconButton(
                onPressed: leadingOnPressed,
                icon: SvgPicture.asset(
                  'assets/icons/navigation/arrow_back.svg',
                  width: 24,
                  height: 24,
                ),
              )
            : const SizedBox(),
        title: Text(
          title,
          style: CustomText.heading4.copyWith(
            color: CustomColor.black,
          ),
        ),
        centerTitle: true,
        actions: !actionDisable
            ? [
                IconButton(
                  onPressed: actionOnPressed,
                  icon: SvgPicture.asset(
                    'assets/icons/outlined/close.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ]
            : null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
