import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/custom_camera_controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/camera_controller_provider.dart';
import 'package:petbuddy_frontend_flutter/route/go_router.dart';
import 'package:universal_html/html.dart' as html;
// import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CameraWebScreen extends ConsumerStatefulWidget {
  const CameraWebScreen({super.key});

  @override
  ConsumerState<CameraWebScreen> createState() => CameraWebScreenState();
}

class CameraWebScreenState extends ConsumerState<CameraWebScreen> with CustomCameraController, RouteAware {
  String _viewType = '';
  late html.VideoElement _videoElement;
  late Widget _htmlWidget;
  String? _capturedImage;

  @override
  void initState() {
    super.initState();
    fnInitCameraController(ref, context);

    _capturedImage = null;
    // 유니크한 viewType 키 생성
    _viewType = 'camera-html-${DateTime.now().microsecondsSinceEpoch}';

    setupHtmlView();
    initializeWebCamera();

    // 카메라 요청
    html.window.navigator.mediaDevices
        ?.getUserMedia({'video': {'facingMode': 'environment'}})
        .then((stream) {
      _videoElement.srcObject = stream;
    }).catchError((e) {
      if(context.mounted) return;
      showAlertDialog(
        context: context, 
        middleText: '카메라 접근 실패: $e'
      );
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   final route = ModalRoute.of(context);
  //   if (route is PageRoute) {
  //     routeObserver.subscribe(this, route);
  //   }
  // }

  @override
  void dispose() {
    // 구독 해지
    // routeObserver.unsubscribe(this);
    // 카메라 스트림 해제
    _videoElement.srcObject?.getTracks().forEach((track) => track.stop());
    _videoElement.srcObject = null;
    _capturedImage = null;

    super.dispose();
  }

  // @override
  // void didPopNext() {
  //   // 기존 스트림 종료
  //   _videoElement.srcObject?.getTracks().forEach((track) => track.stop());
  //   _videoElement.srcObject = null;
  //   setState(() => _capturedImage = null);

  //   // 새로운 viewType 다시 생성
  //   _viewType = 'camera-html-${DateTime.now().microsecondsSinceEpoch}';
  //   setupHtmlView();
  //   initializeWebCamera();
  // }

  void setupHtmlView() {
    _videoElement = html.VideoElement()
      ..autoplay = true
      ..muted = true
      ..setAttribute('playsinline', 'true')
      ..style.objectFit = 'cover'
      ..style.width = '100%'
      ..style.height = '100%';

    // 플랫폼 뷰 등록
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      _viewType, // ✅ 동적으로 설정된 viewType 사용
      (int viewId) => _videoElement,
    );

    setState(() {
      _htmlWidget = HtmlElementView(viewType: _viewType);
    });
  }

  Future<void> initializeWebCamera() async {
    final isIOS = html.window.navigator.userAgent.toLowerCase().contains('iphone') ||
                  html.window.navigator.userAgent.toLowerCase().contains('ipad');

    try {
      final Map<String, dynamic> constraints = {
        'video': {
          'facingMode': isIOS ? {'ideal': 'environment'} : {'exact': 'environment'},
          'width': {'ideal': 1280},
          'height': {'ideal': 720},
        },
        'audio': false
      };

      final stream = await html.window.navigator.mediaDevices!.getUserMedia(constraints);
      _videoElement.srcObject = stream;
      _videoElement.play();
    } catch (e) {
      if(context.mounted) return;
      showAlertDialog(
        context: context, 
        middleText: 'ios 카메라 접근 실패: $e'
      );
    }
  }

  void captureFromVideo() {
    final canvas = html.CanvasElement(
      width: _videoElement.videoWidth,
      height: _videoElement.videoHeight,
    );
    final ctx = canvas.context2D;
    ctx.drawImage(_videoElement, 0, 0);

    final dataUrl = canvas.toDataUrl('image/png');
    setState(() {
      _capturedImage = dataUrl;
    });

    // debugPrint('📸 캡처된 base64 이미지: $dataUrl');
    // TODO: 업로드 처리 (예: HTTP post)
  }

  Future<void> goBack() async {
    fnInvalidateCameraState();
    if(mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      html.window.history.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) async {
          if (!didPop) {
            fnInvalidateCameraState();
            goBack();
          }
        },
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 카메라 프리뷰
              SizedBox.expand(child: _htmlWidget),
          
              // 가이드 프레임
              SizedBox(
                width: 250,
                height: 300,
                child: Column(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Text(
                        '화면의 중앙에 놓아주세요!',
                        style: CustomText.heading5.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFBEFAB).withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/etc/camera_poop.svg',
                      width: 250,
                      height: 250,
                    ),
                  ],
                ),
              ),

              // 카메라 실행 취소
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/etc/camera_close.svg',
                    width: 36,
                    height: 36,
                  ),
                  onPressed: () async {
                    fnInvalidateCameraState();
                    await goBack();
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/etc/camera_image_list.svg',
                          width: 36,
                          height: 36,
                        ),
                        onPressed: () {
                          // 갤러리에서 불러오기
                          fnGetImage(ImageSource.gallery, from: 'camera_screen');
                        },
                      ),
                      const SizedBox(width: 40),
                      GestureDetector(
                        onTap: () async {
                          captureFromVideo();
                        },
                        child: SvgPicture.asset(
                          'assets/icons/etc/camera_button.svg',
                          width: 64,
                          height: 64,
                        ),
                      ),
                      const SizedBox(width: 40),
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/etc/camera_flash_off.svg',
                          width: 36,
                          height: 36,
                        ),
                        onPressed: () async {
                          // 플래시 토글
                          // ref.read(cameraControllerProvider.notifier).toggleFlash(cameraRef);
                          await showAlertDialog(
                            context: context, 
                            middleText: Sentence.WEB_FLASH_ERR_CALL,
                          );
                        },
                      ),
                    ],
                  ),
                )
              ),
          
              // // 캡처된 이미지 미리보기
              // if (_capturedImage != null)
              //   Positioned(
              //     right: 16,
              //     bottom: 16,
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(8),
              //       child: Image.network(
              //         _capturedImage!,
              //         width: 120,
              //         height: 160,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
