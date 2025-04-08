import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';

class HomeCardPetContainer extends StatelessWidget {
  const HomeCardPetContainer({
    super.key,
    this.svgPicture,
    this.onPressed,
  });

  final SvgPicture? svgPicture;
  final VoidCallback? onPressed;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(
        minHeight: 150,
        maxHeight: 200,
      ),
      decoration: const BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.all(Radius.circular(8),),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          onPressed != null ? onPressed!() : null;
        },
        child: svgPicture ?? SvgPicture.asset(
          'assets/icons/illustration/puppy_white.svg',
          width: 100,
          height: 146,
        ),
      )
    );
  }
}
