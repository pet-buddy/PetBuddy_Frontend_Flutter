import 'package:flutter/material.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';

class HomeActivityReportTotalContainer extends StatelessWidget {
  const HomeActivityReportTotalContainer({
    super.key,
    required this.periodCode,
    required this.evaluation,
    this.petName,
    this.petActivity,
    this.petActivityDistance,
    this.userName,
    this.userActivity,
    this.userActivityDistance,
  });

  final String periodCode; // D, W, M, 6M, Y -> 혹시 몰라서 파라미터로 받음
  final String evaluation; // 종합평가 텍스트
  final String? petName;
  final String? petActivity; // 반려동물 활동(명)
  final String? petActivityDistance; // 반려동물 활동거리
  final String? userName;
  final String? userActivity; // 보호자 활동(명)
  final String? userActivityDistance; // 보호자 활동거리
  

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
            '종합평가',
            style: CustomText.heading4.copyWith(
              color: CustomColor.blue03,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8,),
          Text(
            evaluation,
            style: CustomText.caption3.copyWith(
              color: CustomColor.blue01,
            ),
          ),
          const SizedBox(height: 32,),
          Text(
            petActivity ?? '동네 1바퀴',
            style: CustomText.caption3.copyWith(
              color: CustomColor.gray02,
            ),
          ),
          const SizedBox(height: 4,),
          Container(
            width: 120 + double.parse(petActivityDistance ?? '0.0'),
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
                  '${petActivityDistance ?? '0.0'}Km',
                  style: CustomText.caption3.copyWith(
                    color: CustomColor.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),
          Text(
            userActivity ?? '동네 1바퀴',
            style: CustomText.caption3.copyWith(
              color: CustomColor.gray02,
            ),
          ),
          const SizedBox(height: 4,),
          Container(
            width: 120 + double.parse(userActivityDistance ?? '0.0'),
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
                  '${userActivityDistance ?? '0.0'}Km',
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
