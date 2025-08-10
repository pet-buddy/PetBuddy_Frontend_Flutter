import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PawLoadingDialog extends StatefulWidget {
  const PawLoadingDialog({super.key});

  @override
  State<PawLoadingDialog> createState() => PawLoadingDialogState();
}

class PawLoadingDialogState extends State<PawLoadingDialog> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _opacityAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // 애니메이션 총 시간
    );

    // 각 발자국 애니메이션을 위한 Interval 설정
    _opacityAnimations = [
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.3, curve: Curves.easeIn), // 첫 번째 발자국
        ),
      ),
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.3, 0.6, curve: Curves.easeIn), // 두 번째 발자국
        ),
      ),
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.6, 0.9, curve: Curves.easeIn), // 세 번째 발자국
        ),
      ),
    ];

    // 애니메이션 반복
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFootprint(context, 0),
              const SizedBox(width: 20),
              _buildFootprint(context, 1),
              const SizedBox(width: 20),
              _buildFootprint(context, 2),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFootprint(BuildContext context, int index) {
    // 발자국 이미지 경로를 지정해주세요.
    // 프로젝트의 assets 폴더에 이미지를 추가해야 합니다.
    // 예: `assets/footprint.png`
    return Opacity(
      opacity: _opacityAnimations[index].value,
      child: SvgPicture.asset(
        'assets/icons/etc/paw.svg',
        width: 50,
        height: 50,
      ),
    );
  }
}
