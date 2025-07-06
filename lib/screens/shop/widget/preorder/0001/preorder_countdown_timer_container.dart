import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_color.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_text.dart';
import 'package:petbuddy_frontend_flutter/common/utils/fn_get_device_width.dart';
import 'package:petbuddy_frontend_flutter/data/provider/preorder_timer_providers.dart';

class PreorderCountdownTimerContainer extends ConsumerWidget {
  const PreorderCountdownTimerContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(remainingTimeProvider);

    if (duration == null) {
      return const SizedBox.shrink();
    }

    if (duration.isNegative) {
      return Text(
        '마감되었습니다!',
        style: CustomText.body7.copyWith(
          color: CustomColor.white,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    Widget timeBox(String value, String label) {
      return Column(
        children: [
          Text(
            value.padLeft(2, '0'),
            style: CustomText.heading1.copyWith(
              fontSize: fnGetDeviceWidth(context) > 400 ? 32 : 20,
              color: CustomColor.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: CustomText.body7.copyWith(
              fontSize: fnGetDeviceWidth(context) > 400 ? 20 : 18,
              color: CustomColor.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    return SizedBox(
      height: fnGetDeviceWidth(context) >= 500 ? 100 : 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          timeBox('$days', '일'),
          Container(
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              color: CustomColor.white,
            ),
          ),
          timeBox('$hours', '시'),
          Container(
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              color: CustomColor.white,
            ),
          ),
          timeBox('$minutes', '분'),
          Container(
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              color: CustomColor.white,
            ),
          ),
          timeBox('$seconds', '초'),
        ],
      ),
    );
  }
}
