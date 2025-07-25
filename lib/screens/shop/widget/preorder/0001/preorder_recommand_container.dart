import 'package:flutter/material.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';
import 'package:petbuddy_frontend_flutter/common/utils/fn_get_device_width.dart';

class PreorderRecommandContainer extends StatelessWidget {
  const PreorderRecommandContainer({
    super.key,
    required this.text,
  });

  final String text;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: fnGetDeviceWidth(context) / 3.5,
      height: fnGetDeviceWidth(context) / 3.5,
      decoration: BoxDecoration(
        color: CustomColor.white,
        border: Border.all(
          width: 4,
          color: CustomColor.blue04,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(200)),
      ),
      child: Center(
        child: Text(
          text,
          style: CustomText.caption3.copyWith(
            fontSize: fnGetDeviceWidth(context) > 400 ? 12 : 10,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
