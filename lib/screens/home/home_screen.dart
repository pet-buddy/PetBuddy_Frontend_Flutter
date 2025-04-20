import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/home_controller.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';
import 'package:petbuddy_frontend_flutter/screens/home/widget/widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> with HomeController {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          await fnClose(context);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16,),
                  Text(
                    '탄이, 반가워요!',
                    style: CustomText.heading1.copyWith(
                      color: CustomColor.blue03,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/etc/heart.svg',
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 8,),
                      Text(
                        '하트코인(준비 중)',
                        style: CustomText.body10.copyWith(
                          color: CustomColor.gray03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Text(
                        NumberFormat('###,###,###,###').format(1350),
                        style: CustomText.body10.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 52,
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          // TODO : loop로 데이터 받아 출력
                          HomeCardMissionContainer(
                            imoji: '🐕',
                            title: '산책하기', 
                            text: '4시간 뒤 소멸'
                          ),
                          HomeCardMissionContainer(
                            imoji: '🍖',
                            title: '맘마주기', 
                            text: '1시간 뒤 소멸'
                          ),
                          HomeCardMissionContainer(
                            imoji: '💩',
                            title: '똥 찍기', 
                            text: '2시간 뒤 소멸'
                          ),
                          HomeCardMissionContainer(
                            imoji: '😴',
                            title: '낮잠재우기', 
                            text: '2시간 뒤 소멸'
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: PageView(
                      controller: homePageController,
                      children: [
                        HomeCardPetContainer(
                          onPressed: () {
                            
                          },
                        ),
                        HomeCardPetContainer(
                          svgPicture: SvgPicture.asset(
                            'assets/icons/illustration/puppy_yellow.svg',
                            width: 100,
                            height: 146,
                          ),
                          onPressed: () {
                            
                          },
                        ),
                        HomeCardPetContainer(
                          svgPicture: SvgPicture.asset(
                            'assets/icons/illustration/puppy_black.svg',
                            width: 100,
                            height: 146,
                          ),
                          onPressed: () {
                            
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCardManageContainer(
                        thumbnailColor: const Color(0xFF0092CA).withValues(alpha: 0.5),
                        title: "걸음 수", 
                        thumbnailPicture: SvgPicture.asset(
                          'assets/icons/etc/Dog.svg',
                          width: 20,
                          height: 20,
                        ),
                        onPressed: () {
                          context.goNamed("home_activity_report_screen");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              NumberFormat('###,###,###,###').format(23245),
                              style: CustomText.body4.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8,),
                            Text(
                              '걸음',
                              style: CustomText.caption2.copyWith(
                                color: CustomColor.gray02,
                              ),
                            )
                          ],
                        ),
                      ),
                      HomeCardManageContainer(
                        thumbnailColor: const Color(0xFFCAA384).withValues(alpha: 0.2),
                        title: "똥 건강", 
                        thumbnailPicture: SvgPicture.asset(
                          'assets/icons/etc/poop.svg',
                          width: 20,
                          height: 20,
                        ),
                        child: Container(
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.all(Radius.circular(12),),
                          ),
                          child: LayoutBuilder(builder: (context, contraints) {
                            return Row(
                              children: [
                                Container(
                                  width: contraints.maxWidth / 3,
                                  height: contraints.maxHeight,
                                  decoration: const BoxDecoration(
                                    color:  Color(0xFFF1EBE5),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12),),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '양호',
                                      style: CustomText.caption2.copyWith(
                                        color: CustomColor.gray02,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: contraints.maxWidth / 3,
                                  height: contraints.maxHeight,
                                  decoration: const BoxDecoration(
                                    color:  Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12),),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '주의',
                                      style: CustomText.caption2.copyWith(
                                        color: CustomColor.gray02,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: contraints.maxWidth / 3,
                                  height: contraints.maxHeight,
                                  decoration: const BoxDecoration(
                                    color:  Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12),),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '위험',
                                      style: CustomText.caption2.copyWith(
                                        color: CustomColor.gray02,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCardManageContainer(
                        thumbnailColor: const Color(0xFFD7EBFF),
                        title: "수면 효율",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '55',
                              style: CustomText.body4.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8,),
                            Text(
                              '%',
                              style: CustomText.caption2.copyWith(
                                color: CustomColor.gray02,
                              ),
                            ),
                          ],
                        ),
                      ),
                      HomeCardManageContainer(
                        thumbnailColor: const Color(0xFFDCEEE1),
                        title: "곳간", 
                        thumbnailPicture: SvgPicture.asset(
                          'assets/icons/etc/feed.svg',
                          width: 20,
                          height: 20,
                        ),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Stack(
                            children: [
                              Container(
                                width: constraints.maxWidth,
                                height: 45,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.all(Radius.circular(12),),
                                ),
                              ),
                              Container(
                                width: constraints.maxWidth * 0.6,
                                height: 45,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFDCEEE1),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth,
                                height: 45,
                                child: Center(
                                  child: Text(
                                    '20일 정도 먹을 수 있어요!',
                                    style: CustomText.caption3.copyWith(
                                      color: CustomColor.gray02,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  HomeCardReportContainer(
                    subTitle: '탄이는 다음 3가지 관리가 필요해요!',
                    reportList: [
                      HomeCardReportModel(
                        title: '#활동량', 
                        content: '아침, 저녁 산책을 권장드려요!'
                      ),
                      HomeCardReportModel(
                        title: '#수면', 
                        content: '30분 낮잠이 필요한 것 같아요'
                      ),
                      HomeCardReportModel(
                        title: '#규칙적인 습관', 
                        content: '간식은 정해진 시간에 챙겨줘야 해요'
                      ),
                    ],
                  ),
                  OutlinedButton(onPressed: () {
                    //context.goNamed("home_activity_report_screen");
                    // showAlertDialog(context: context, middleText: 'teeeee');
                    showConfirmDialog(context: context, middleText: 'teeeee', onConfirm: () {});
                  }, child: Text('test')),
                  const SizedBox(height: 32,),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
