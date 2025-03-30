import 'package:flutter/material.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';

class HomeActivityReportContainer extends StatelessWidget {
  const HomeActivityReportContainer({
    super.key,
    required this.periodCode,
    required this.assessment,
    this.petName,
    this.petActivitySteps,
    this.userName,
    this.userActivitySteps,
  });

  final String periodCode; // D, W, M, 6M, Y
  final String assessment; // 평가 텍스트
  final String? petName;
  final String? petActivitySteps; // 반려동물 걸음수
  final String? userName;
  final String? userActivitySteps; // 보호자 걸음수
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(
        minWidth: 344,
        minHeight: 196,
      ),
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: const BorderRadius.all(Radius.circular(8),),
        boxShadow: [
          BoxShadow(
            color: CustomColor.gray04..withValues(alpha: 0.0),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 0),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${
              periodCode == 'D' 
                ? '오늘'
                : periodCode == 'W'
                  ? '최근 1주'
                    : periodCode == 'M'
                      ? '최근 1달'
                        : periodCode == '6M'
                          ? '최근 6달'
                            : periodCode == 'Y'
                              ? '최근 1년'
                                : '오늘'
            }의 활동 분석',
            style: CustomText.heading4.copyWith(
              color: CustomColor.blue03,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8,),
          Text(
            assessment,
            style: CustomText.caption3.copyWith(
              color: CustomColor.blue01,
            ),
          ),
          const SizedBox(height: 32,),
          Container(
            width: 120 + double.parse(petActivitySteps ?? '0'),
            height: 23,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: const BoxDecoration(
              color: CustomColor.blue03,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), 
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    petName ?? '반려동물',
                    overflow: TextOverflow.ellipsis,
                    style: CustomText.caption3.copyWith(
                      color: CustomColor.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${petActivitySteps ?? '0'} 걸음',
                  style: CustomText.caption3.copyWith(
                    color: CustomColor.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          Container(
            width: 120 + double.parse(userActivitySteps ?? '0'),
            height: 23,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: const BoxDecoration(
              color: CustomColor.yellow03,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), 
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    userName ?? '보호자',
                    style: CustomText.caption3.copyWith(
                      color: CustomColor.blue01,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${userActivitySteps ?? '0'} 걸음',
                  style: CustomText.caption3.copyWith(
                    color: CustomColor.blue01,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
