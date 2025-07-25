import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_color.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_text.dart';
import 'package:petbuddy_frontend_flutter/common/utils/fn_get_device_width.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/home_activated_pet_nav_provider.dart';
import 'package:petbuddy_frontend_flutter/data/provider/response_dogs_provider.dart';
import 'package:petbuddy_frontend_flutter/data/provider/response_poo_daily_status_provider.dart';
import 'package:petbuddy_frontend_flutter/screens/home/widget/inverted_triangle_painter.dart';

class HomePoopDailyReportDialog extends ConsumerStatefulWidget {
  final String date;

  const HomePoopDailyReportDialog({
    super.key,
    required this.date,
  });

  @override
  ConsumerState<HomePoopDailyReportDialog> createState() => HomePoopDailyReportDialogState();
}

class HomePoopDailyReportDialogState extends ConsumerState<HomePoopDailyReportDialog> with HomeController {
  @override
  void initState() {
    super.initState();
    fnInitHomeController(ref, context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeActivatedPetNav = ref.read(homeActivatedPetNavProvider.notifier).get();
      final responseDogs = ref.read(responseDogsProvider.notifier).get();

      // 반려동물 특정날짜 건강점수
      fnPooDailyStatusExec(widget.date, responseDogs[homeActivatedPetNav].pet_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsePooDailyStatusState = ref.watch(responsePooDailyStatusProvider);
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
        decoration: const BoxDecoration(
          color: CustomColor.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.date,
                style: CustomText.body10,
              ),
              const Divider(thickness: 1,),
              const SizedBox(height: 8,),
              Container(
                width: fnGetDeviceWidth(context),
                height: fnGetDeviceWidth(context) * 1.2 - 32,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: CustomColor.black,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    responsePooDailyStatusState.poop_url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${responsePooDailyStatusState.poop_score_total}',
                      style: CustomText.heading1.copyWith(
                        fontSize: 48.0,
                        color: const Color(0xFF0092CA),
                      ),
                    ),
                    const SizedBox(width: 4,),
                    Text(
                      '점',
                      style: CustomText.body9.copyWith(
                        color: const Color(0xFF00467E),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8,),
              Row(
                children: [
                  Container(
                    height: 48,
                    margin: const EdgeInsets.only(top: 12),
                    child: Text(
                      '종합',
                      style: CustomText.body9.copyWith(
                        color: const Color(0xFF00467E),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: fnGetDeviceWidth(context) - 128,
                    height: 48,
                    child: Stack(
                      children: [
                        // 상태 가로 막대그래프
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: LayoutBuilder(builder: (context, contraints) {
                            return Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: contraints.maxWidth / 3,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color:  Color(0xFFF62548),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10),),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      width: contraints.maxWidth / 3,
                                      child: Text(
                                        '나쁨',
                                        style: CustomText.caption3.copyWith(
                                          color: const Color(0xFF00467E),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: contraints.maxWidth / 3,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color:  Color(0xFFF6D72E),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      width: contraints.maxWidth / 3,
                                      child: Text(
                                        '보통',
                                        style: CustomText.caption3.copyWith(
                                          color: const Color(0xFF00467E),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: contraints.maxWidth / 3,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color:  Color(0xFF63C728),
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10),),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      width: contraints.maxWidth / 3,
                                      child: Text(
                                        '건강',
                                        style: CustomText.caption3.copyWith(
                                          color: const Color(0xFF00467E),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                        // 점수를 가리킬 아래 화살표
                        Positioned(
                          top: 0,
                          // 1.5보다 적을 때 1.5로 세팅, 98.5보다 클 때 98.5로 세팅
                          left: (fnGetDeviceWidth(context) - 128) * ((responsePooDailyStatusState.poop_score_total < 1.5 ? 1.5 : responsePooDailyStatusState.poop_score_total > 98.5 ? 98.5 : responsePooDailyStatusState.poop_score_total)/100) - 5,
                          child: CustomPaint(
                            size: const Size(10, 10), // 캔버스 크기
                            painter: InvertedTrianglePainter(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              // 변 건강 상태 색깔로 출력
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '색상',
                        style: CustomText.caption3.copyWith(
                          color: const Color(0xFF00467E),
                        ),
                      ),
                      const SizedBox(height: 4,),
                      SvgPicture.asset(
                        'assets/icons/etc/status_${fnGetPoopStatus(responsePooDailyStatusState.poop_score_color)}.svg',
                        width: 35,
                        height: 35,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '수분',
                        style: CustomText.caption3.copyWith(
                          color: const Color(0xFF00467E),
                        ),
                      ),
                      const SizedBox(height: 4,),
                      SvgPicture.asset(
                        'assets/icons/etc/status_${fnGetPoopStatus(responsePooDailyStatusState.poop_score_moisture)}.svg',
                        width: 35,
                        height: 35,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '기생충 여부',
                        style: CustomText.caption3.copyWith(
                          color: const Color(0xFF00467E),
                        ),
                      ),
                      const SizedBox(height: 4,),
                      SvgPicture.asset(
                        'assets/icons/etc/status_${fnGetPoopStatus(responsePooDailyStatusState.poop_score_parasite)}.svg',
                        width: 35,
                        height: 35,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }
}