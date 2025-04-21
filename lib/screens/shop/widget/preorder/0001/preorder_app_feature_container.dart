import 'package:flutter/material.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';

class PreorderAppFeatureContainer extends StatelessWidget {
  const PreorderAppFeatureContainer({
    super.key,
    required this.img,
    required this.text,
  });

  final String img;
  final String text;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/icons/preorder/$img',
          width: 80,
          height: 80,
        ),
        const SizedBox(height: 8,),
        Text(
          text,
          style: CustomText.caption3,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
