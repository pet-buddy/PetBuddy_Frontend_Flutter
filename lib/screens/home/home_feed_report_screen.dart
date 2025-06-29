import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';

class HomeFeedReportScreen extends ConsumerStatefulWidget {
  const HomeFeedReportScreen({super.key});

  @override
  ConsumerState<HomeFeedReportScreen> createState() => HomeFeedReportScreenState();
}

class HomeFeedReportScreenState extends ConsumerState<HomeFeedReportScreen> with HomeController {

  @override
  void initState() {
    super.initState();
    fnInitHomeController(ref, context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '사료 보고서',
        leadingOnPressed: () {
          if(!context.mounted) return;
          context.pop();
        },
        actionDisable: true,
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          // await fnClose(context);
        },
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 64,), // TODO : 정식 출시 후 삭제
                      const SizedBox(height: 16,), 
                      Text(
                        '사료 적합성 분석',
                        style: CustomText.body5.copyWith(
                          fontWeight: FontWeight.bold,
                          color: CustomColor.blue03,
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Text(
                        '탄이의 활동량, 수면패턴 그리고 똥 건강을 분석해 사료가 얼마나 잘 맞는지 분석했어요.',
                        style: CustomText.caption3.copyWith(
                          color: CustomColor.blue01,
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          // TODO : 점수 받아오기
                          Text(
                            '77',
                            style: CustomText.heading1.copyWith(
                              color: CustomColor.blue03,
                            ),
                          ),
                          const SizedBox(width: 4,),
                          Text(
                            '점',
                            style: CustomText.body9.copyWith(
                              color: CustomColor.gray03,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4,),
                      Text(
                        '포프린트 사료 급여 (푸들) 평균 93점',
                        style: CustomText.caption3.copyWith(
                          color: CustomColor.blue02,
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        width: fnGetDeviceWidth(context),
                        height: 120,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: const BoxDecoration(
                          color: CustomColor.white
                        ),
                        child: CustomPaint(
                          painter: BoneGraphPainter(),
                        ),
                      ),
                      const SizedBox(height: 32,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DefaultTextButton(
                          text: '사료를 변경 / 채웠어요!', 
                          onPressed: () async {
                            
                          },
                          disabled: false,
                          borderRadius: 32.0,
                        ),
                      ),
                      const SizedBox(height: 32,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16),
                        constraints: const BoxConstraints(
                          minWidth: 350,
                          minHeight: 200,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '적합성 분석 기준',
                              style: CustomText.body8.copyWith(
                                fontWeight: FontWeight.bold,
                                color: CustomColor.blue03,
                              ),
                            ),
                            const SizedBox(height: 16,),
                            Text(
                              '일일 건강 데이터를 분석해본 결과,',
                              style: CustomText.body11.copyWith(
                                color: CustomColor.blue02,
                              ),
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                const Icon(Icons.circle, color: Color(0xFF63C728), size: 10),
                                const SizedBox(width: 8,),
                                Text(
                                  '활동량이 안정적이에요!',
                                  style: CustomText.body11.copyWith(
                                    color: CustomColor.blue02,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                const Icon(Icons.circle, color: Color(0xFFF62548), size: 10),
                                const SizedBox(width: 8,),
                                Text(
                                  '반면 수면은 불규칙적이에요!',
                                  style: CustomText.body11.copyWith(
                                    color: CustomColor.blue02,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                const Icon(Icons.circle, color: Color(0xFF63C728), size: 10),
                                const SizedBox(width: 8,),
                                Text(
                                  '똥의 색상은 정상, 수분도는 정상이에요!',
                                  style: CustomText.body11.copyWith(
                                    color: CustomColor.blue02,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DefaultTextButton(
                          text: '사료 궁합 점수 올리는 팁', 
                          onPressed: () async {
                            
                          },
                          disabled: false,
                          borderRadius: 32.0,
                        ),
                      ),
                      const SizedBox(height: 64,),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 8,
                left: 16,
                right: 16,
                child: Container(
                  width: fnGetDeviceWidth(context),
                  height: 50,
                  decoration: BoxDecoration(
                    color: CustomColor.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        width: 1,
                        color: CustomColor.gray03,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CustomColor.gray04..withValues(alpha: 0.0),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '해당 화면은 예시 화면입니다.',
                        style: CustomText.body9.copyWith(
                          color: CustomColor.gray02,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 뼈다귀 모양 그래프
class BoneGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double boneHeight = 60;
    const double boneRadius = boneHeight / 2;
    const double circleRadius = 50;
    const double x = 50;
    final double y = size.height / 2;
    final double bodyWidth = size.width - (x * 2);
    

    final Paint bonePaint = Paint()
      ..shader = const LinearGradient(
        colors: [CustomColor.blue03, CustomColor.yellow03],
      ).createShader(Rect.fromLTWH(0, y - boneHeight / 2, size.width/1.2, boneHeight));

    // 뼈다귀 모양 그리기
    final Path bonePath = Path();

    // 왼쪽 원
    bonePath.addOval(Rect.fromCircle(center: Offset(x, y - 20), radius: circleRadius/1.5));
    bonePath.addOval(Rect.fromCircle(center: Offset(x, y + 20), radius: circleRadius/1.5));

    // 오른쪽 원
    bonePath.addOval(Rect.fromCircle(center: Offset(size.width - x, y - 20), radius: circleRadius/1.5));
    bonePath.addOval(Rect.fromCircle(center: Offset(size.width - x, y + 20), radius: circleRadius/1.5));

    // 가운데 직사각형 연결
    bonePath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(x, y - boneHeight / 2, bodyWidth, boneHeight),
      const Radius.circular(boneRadius),
    ));

    canvas.drawPath(bonePath, bonePaint);
    
    const double dashHeight = 3;
    const double dashSpace = 2;
    final Paint dashPaint = Paint()
      ..color = CustomColor.white
      ..strokeWidth = 1;

    double dashX = x + (circleRadius / 1.5) + ((77/100)*bodyWidth - (circleRadius / 1.5));
    double dashY = y - boneHeight / 2 - 1;

    while (dashY < y + boneHeight / 2) {
      canvas.drawLine(Offset(dashX, dashY), Offset(dashX, dashY + dashHeight), dashPaint);
      dashY += dashHeight + dashSpace;
    }

    double textY = y + x + 10;

    // 점수 텍스트
    const textStyle = TextStyle(color: CustomColor.gray03, fontSize: 12);

    final textPainter70 = TextPainter(
      text: const TextSpan(text: '0점', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter70.paint(canvas, Offset(x + (circleRadius / 1.5), textY));

    final textPainter85 = TextPainter(
      text: const TextSpan(text: '50점', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter85.paint(canvas, Offset((x + (circleRadius / 1.5) + (0.5*bodyWidth - (circleRadius / 1.5)) - 10), textY));

    final textPainter100 = TextPainter(
      text: const TextSpan(text: '100점', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter100.paint(canvas, Offset( (circleRadius / 1.5) + (bodyWidth - (circleRadius / 1.5)), textY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
