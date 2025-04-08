import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';

class HomeCardReportContainer extends StatelessWidget {
  const HomeCardReportContainer({
    super.key,
    this.thumbnailColor,
    this.title,
    this.thumbnailPicture,
    required this.child,
    required this.subTitle,
  });

  final Color? thumbnailColor;
  final String? title;
  final SvgPicture? thumbnailPicture;
  final Widget child;
  final String subTitle;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: const BorderRadius.all(Radius.circular(12),),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: thumbnailColor ?? const Color(0xFFFFEF5E).withValues(alpha: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(12),),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: thumbnailPicture ?? const SizedBox(),
                ),
              ),
              const SizedBox(width: 8,),
              Text(
                title ?? '분석 레포트',
                style: CustomText.body9,
              )
            ],
          ),
          const SizedBox(height: 8,),
          Container(
            height: 1,
            color: CustomColor.gray05,
          ),
          const SizedBox(height: 8,),
          Text(
            subTitle,
            style: CustomText.body11,
          ),
          const SizedBox(height: 8,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 258,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 160,
                    constraints: const BoxConstraints(
                      minHeight: 200,
                      maxHeight: 240,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0092CA).withValues(alpha: 0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(12),),
                    ),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#활동량',
                          style: CustomText.body10.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        Flexible(
                          child: const Text(
                            '활동량 내용',
                            style: CustomText.body11,
                            softWrap: false,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    constraints: const BoxConstraints(
                      minHeight: 200,
                      maxHeight: 240,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0092CA).withValues(alpha: 0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(12),),
                    ),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#활동량',
                          style: CustomText.body10.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        const Text(
                          '활동량 내용이에요\n활동량 내용이에요활동량 내용이에요활동량 내용이에요활동량 내용이에요',
                          style: CustomText.body11,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    constraints: const BoxConstraints(
                      minHeight: 200,
                      maxHeight: 240,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0092CA).withValues(alpha: 0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(12),),
                    ),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#활동량',
                          style: CustomText.body10.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8,),
                        const Text(
                          '활동량 내용이에요\n활동량 내용이에요활동량 내용이에요활동량 내용이에요활동량 내용이에요',
                          style: CustomText.body11,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
