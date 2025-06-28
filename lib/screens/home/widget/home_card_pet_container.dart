import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';
import 'package:petbuddy_frontend_flutter/common/utils/fn_get_device_width.dart';

class HomeCardPetContainer extends StatelessWidget {
  const HomeCardPetContainer({
    super.key,
    required this.petImg,
    this.petOptions,
    this.onPressed,
  });

  final Widget petImg;
  final List<String>? petOptions;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("HomeCardPetContainer tapped");
        onPressed != null ? onPressed!() : null;
      },
      child: Container(
        width: fnGetDeviceWidth(context),
        height: fnGetDeviceWidth(context),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: const BoxDecoration(
          color: CustomColor.white,
          image: DecorationImage(
            image: AssetImage('assets/icons/illustration/background.jpeg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8),),
        ),
        child: Stack(
          children: [
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: fnGetDeviceWidth(context) * 0.2,
            //   child: SvgPicture.asset(
            //     'assets/icons/illustration/puppy_white.svg',
            //     width: fnGetDeviceWidth(context) * 0.3,
            //     height: fnGetDeviceWidth(context) * 0.35,
            //   ),
            // ),

            petImg,
          ],
        ),
      ),
    );
  }
}
