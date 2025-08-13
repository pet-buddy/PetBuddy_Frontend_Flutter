import 'package:flutter/material.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';
import 'package:petbuddy_frontend_flutter/common/utils/fn_get_device_width.dart';

class HomeHorizontalBarChartContainer extends StatelessWidget {
  const HomeHorizontalBarChartContainer({
    super.key,
    required this.text,
    this.textColor,
    this.barColor,
    required this.score,
    this.textSpanList,
    required this.flag,
  });

  final String text;
  final Color? textColor;
  final Color? barColor;
  final double score;
  final List<TextSpan>? textSpanList;
  final String flag;

  @override
  Widget build(BuildContext context) {
    double denominator = (flag == 'activity' 
                            ? 10000 : 
                                flag == 'sleep' ?
                                100 : 1);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            RichText(
                text: TextSpan(
                    text: text,
                    style: CustomText.body11.copyWith(
                        color: textColor ?? CustomColor.blue03
                    ),
                    children: textSpanList ?? <TextSpan>[],
                ),
            ),
            Container(
                width: fnGetDeviceWidth(context) * (score / denominator),
                height: 20,
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: barColor ?? CustomColor.blue03,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20), 
                        bottomRight: Radius.circular(20),
                    ),
                ),
            ),
            const SizedBox(height: 8,),
        ],
    );
  }
}
