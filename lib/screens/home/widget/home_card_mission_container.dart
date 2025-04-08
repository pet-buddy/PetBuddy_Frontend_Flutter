import 'package:flutter/material.dart';
import 'package:petbuddy_frontend_flutter/common/const/const.dart';

class HomeCardMissionContainer extends StatelessWidget {
  const HomeCardMissionContainer({
    super.key,
    required this.imoji,
    required this.title,
    required this.text,
  });

  final String imoji;
  final String title;
  final String text;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(
        minWidth: 120,
        maxWidth: 140,
        minHeight: 100,
        maxHeight: 120
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.all(Radius.circular(8),),
      ),
      margin: const EdgeInsets.only(right: 8),
      child: Row(
        children: [
          Text(
            imoji,
            style: CustomText.body8,
          ),
          const SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: CustomText.caption3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                text,
                style: CustomText.caption3,
              ),
            ],
          )
        ],
      )
    );
  }
}
