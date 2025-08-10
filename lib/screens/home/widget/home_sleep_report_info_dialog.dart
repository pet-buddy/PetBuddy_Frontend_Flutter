import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_color.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_text.dart';

class HomeSleepReportInfoDialog extends StatelessWidget {
  const HomeSleepReportInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: CustomColor.white,
          borderRadius: BorderRadius.all(Radius.circular(16),),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: SvgPicture.asset(
                'assets/icons/action/close.svg',
                width: 16,
                height: 16,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4,),
                      Text(
                        '수면레포트란?',
                        style: CustomText.heading4.copyWith(
                          color: CustomColor.blue03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16,),
                      Text(
                        '수면 레포트는 반려동물의 수면량을 수치화한 지표입니다.',
                        style: CustomText.body11.copyWith(
                          color: CustomColor.deepYellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/etc/sleep_cloud.svg',
                            width: 120,
                            height: 87,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24,),
                      Text(
                        '반려동물의 수면 상태도 사람처럼 건강 상태를 나타내는 지표 중 하나입니다.',
                        style: CustomText.body11.copyWith(
                          color: CustomColor.blue03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' 수면 패턴과 시간의 변화는 반려동물이 깨어 있는 동안의 경험과 자신의 환경에서 얼마나 편안한 지를 반영할 수 있습니다. 뿐만 아니라 수면 장애는 인지 및 신체 기능, 면역 반응, 통증 감각과 같은 생리 기능에 영향을 미치고 질병 위험을 증가시킵니다.',
                        style: CustomText.body11.copyWith(
                          color: CustomColor.blue03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/etc/documents.svg',
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24,),
                      Text(
                        '이 때문에 포프린트는 수면 데이터를 수집하여 우리 강아지가 평온하고 행복한 삶을 살 수 있도록 지원해드리려고 해요!',
                        style: CustomText.body11.copyWith(
                          color: CustomColor.deepYellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' 가이드라인에 맞춰 반려동물의 수면 건강을 관리해보세요 🙂',
                        style: CustomText.body11.copyWith(
                          color: CustomColor.blue03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24,),
                      Text(
                        '[원형그래프 설명]',
                        style: CustomText.caption3.copyWith(
                          color: CustomColor.blue03,
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0092CA),
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                          const SizedBox(width: 4,),
                          Text(
                            '반려동물 실제 수면 시간',
                            style: CustomText.caption3.copyWith(
                              color: CustomColor.blue03,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFBBE0C),
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                          const SizedBox(width: 4,),
                          Text(
                            '반려동물 권장 수면 시간',
                            style: CustomText.caption3.copyWith(
                              color: CustomColor.blue03,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Color(0xFF00CBA7),
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                          const SizedBox(width: 4,),
                          Text(
                            '권장 수면 시간과 실제 수면 시간의 중복 시간',
                            style: CustomText.caption3.copyWith(
                              color: CustomColor.blue03,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
