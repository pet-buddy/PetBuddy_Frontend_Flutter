import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_color.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_text.dart';

class HomeCardReportFlipContainer extends ConsumerStatefulWidget {
  final String title;
  final String backText;
  final SvgPicture frontIcon;

  const HomeCardReportFlipContainer({
    super.key,
    required this.title,
    required this.backText,
    required this.frontIcon,
  });

  @override
  ConsumerState<HomeCardReportFlipContainer> createState() => HomeCardReportFlipContainerState();
}

class HomeCardReportFlipContainerState extends ConsumerState<HomeCardReportFlipContainer> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool isFront = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void toggleCard() {
    if (isFront) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    isFront = !isFront;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget buildFrontCard() {
    return flipContainer(
      SizedBox(
        height: fnGetDeviceWidth(context) >= 400 ? 160 : 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.frontIcon,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBackCard() {
    return flipContainer(
      Flexible(
        child: Text(
          widget.backText,
          style: CustomText.body11.copyWith(
            color: CustomColor.white
          ),
          softWrap: true,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }

  Widget flipContainer(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // 블러 효과
        child: Container(
          width: fnGetDeviceWidth(context) >= 400 ? 160 : 140,
          constraints: BoxConstraints(
            minHeight: fnGetDeviceWidth(context) >= 400 ? 200 : 180,
            maxHeight: fnGetDeviceWidth(context) >= 400 ? 240 : 220,
          ),
          decoration: BoxDecoration(
            color: CustomColor.blue06.withValues(alpha: 0.7),
            borderRadius: const BorderRadius.all(Radius.circular(12),),
            border: Border.all(
                width: 1,
                color: CustomColor.white.withValues(alpha: 0.4),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          // margin: const EdgeInsets.only(right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: CustomText.body10.copyWith(
                  color: CustomColor.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCard,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          final angle = animationController.value * pi;
          final isFrontVisible = angle < pi / 2;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateY(angle),
            child: isFrontVisible
                ? buildFrontCard()
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: buildBackCard(),
                  ),
          );
        },
      ),
    );
  }
}
