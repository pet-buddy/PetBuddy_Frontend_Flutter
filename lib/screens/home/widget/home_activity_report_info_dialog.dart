import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_color.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_text.dart';

class HomeActivityReportInfoDialog extends StatelessWidget {
  const HomeActivityReportInfoDialog({super.key});

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
                        'Paws란?',
                        style: CustomText.heading4.copyWith(
                          color: CustomColor.blue03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16,),
                      Text(
                        'Paws는 반려동물의 활동량을 수치화한 지표입니다.',
                        style: CustomText.body11.copyWith(
                          color: const Color(0xFFEB9824),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/etc/paw_question.svg',
                            width: 100,
                            height: 106,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24,),
                      Text(
                        '반려동물은 사람과 달리 걸음 수만으로 건강 상태를 평가하기 어렵습니다.',
                        style: CustomText.body11.copyWith(
                          color: CustomColor.blue03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' 예를 들어, 1km 달리기는 1km 걷기보다 걸음 수는 적지만 더 활동적인 운동이죠. 따라서 걸음 수만으로는 정확한 건강 분석이 불가능합니다.',
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
                        '이에 저희는 미국 FitBark사의 연구 기준을 바탕으로 활동량 표준을 도입했습니다.',
                        style: CustomText.body11.copyWith(
                          color: const Color(0xFFEB9824),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/preorder/0001/puppy_tracker.png',
                            width: 120,
                            height: 120,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24,),
                      Text(
                        'Paws는 목줄 센서의 움직임을 초당 여러 번 측정해 1분 단위로 누적한 점수입니다. 많이 움직일수록 점수가 높고, 쉬는 동안에는 분당 몇 점만 기록됩니다.',
                        style: CustomText.body11.copyWith(
                          color: CustomColor.blue03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' 즉, PawPoint는 반려동물이 얼마나 활발하게 움직였는지를 과학적으로 보여주는 활동량 지표입니다.',
                        style: CustomText.body11.copyWith(
                          color: CustomColor.blue03,
                          fontWeight: FontWeight.bold,
                        ),
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
