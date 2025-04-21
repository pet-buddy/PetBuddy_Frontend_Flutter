import 'package:flutter/material.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';
import 'package:petbuddy_frontend_flutter/common/utils/fn_get_device_width.dart';

class PreorderBenefitContainer extends StatelessWidget {
  const PreorderBenefitContainer({
    super.key,
    this.img,
    required this.title,
    required this.text,
  });

  final String? img;
  final String title;
  final String text;
  
  @override
  Widget build(BuildContext context) {
    double _width = fnGetDeviceWidth(context) / 2.5 + 48;
    double _height = fnGetDeviceWidth(context) / 2.5 + 16;

    return Container(
      width: _width,
      height: _height,
      decoration: const BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: _width,
            height: _height / 2,
            padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
            child: img != null ?
              Image.asset(
                'assets/icons/preorder/$img',
              ) :
              const SizedBox(),
          ),
          Container(
            width: _width,
            height: _height / 2,
            decoration: const BoxDecoration(
              color: Color(0xFF9F6F53),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: CustomText.body10.copyWith(
                    color: CustomColor.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4,),
                Text(
                  text,
                  style: CustomText.caption3.copyWith(
                    color: CustomColor.white,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
