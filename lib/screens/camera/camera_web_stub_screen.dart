import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/custom_camera_controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/camera_image_picker_provider.dart';
import 'package:petbuddy_frontend_flutter/data/provider/camera_upload_button_provider.dart';
import 'package:universal_html/html.dart' as html;
// import 'dart:html' as html;
// import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

class CameraWebScreen extends ConsumerStatefulWidget {
  const CameraWebScreen({super.key});

  @override
  ConsumerState<CameraWebScreen> createState() => CameraWebScreenState();
}

class CameraWebScreenState extends ConsumerState<CameraWebScreen> with CustomCameraController {
  String _viewType = '';
  late html.VideoElement _videoElement;
  late Widget _htmlWidget;

  @override
  void initState() {
    super.initState();
    fnInitCameraController(ref, context);

    // 유니크한 viewType 키 생성
    _viewType = 'camera-html-${DateTime.now().microsecondsSinceEpoch}';

    initializeCameraWeb();
  }

  @override
  void dispose() {
    // 카메라 스트림 해제
    // _videoElement.srcObject?.getTracks().forEach((track) => track.stop());
    _videoElement.srcObject = null;

    super.dispose();
  }

  Future<void> initializeCameraWeb() async {
    _videoElement = html.VideoElement()
      ..autoplay = true
      ..muted = true
      ..setAttribute('playsinline', 'true')
      ..style.objectFit = 'cover'
      ..style.width = '100%'
      ..style.height = '100%';

    // 플랫폼 뷰 등록
    // ui_web.platformViewRegistry.registerViewFactory(
    //   _viewType, // 동적으로 설정된 viewType 사용
    //   (int viewId) => _videoElement,
    // );

    setState(() {
      _htmlWidget = HtmlElementView(viewType: _viewType);
    });

    final isIOS = html.window.navigator.userAgent.toLowerCase().contains('iphone') ||
                  html.window.navigator.userAgent.toLowerCase().contains('ipad');

    final Map<String, dynamic> constraints = isIOS ? {
      'video': {
        'facingMode': {'ideal': 'environment'},
        'width': {'ideal': 1280},
        'height': {'ideal': 720},
      },
      'audio': false
    } : {
      'video': {'facingMode': 'environment'}, 
      'audio': false
    };             

    try {
      // 카메라 권한 상태 확인
      final permission = await html.window.navigator.permissions?.query({'name': 'camera'});

      final state = permission?.state;

      if (state == 'denied') {
        if (!context.mounted) return;
        showAlertDialog(
          context: context,
          middleText: '카메라 권한이 거부되었습니다.\n브라우저 설정에서 권한을 허용해주세요.',
        );
        return;
      }

      final stream = await html.window.navigator.mediaDevices?.getUserMedia(constraints);
      _videoElement.srcObject = stream;
    } catch(e) {
      if(!context.mounted) return;
      showAlertDialog(
        context: context, 
        middleText: '카메라 접근 실패: $e',
      );
    }

    // html.window.navigator.mediaDevices?.
    //   getUserMedia(constraints).then((stream) {
    //   _videoElement.srcObject = stream;
    // }).catchError((e) {
    //   if(!context.mounted) return;
    //   showAlertDialog(
    //     context: context, 
    //     middleText: '카메라 접근 실패: $e'
    //   );
    // });
  }

  Future<void> captureFromVideo() async {
    final canvas = html.CanvasElement(
      // width: _videoElement.videoWidth,
      // height: _videoElement.videoHeight,
    );
    final ctx = canvas.context2D;
    ctx.drawImage(_videoElement, 0, 0);

    final dataUrl = canvas.toDataUrl('image/png');
    
    // base64 → Uint8List
    final base64String = dataUrl.split(',').last;
    final bytes = base64Decode(base64String);

    // 메모리에서 만든 XFile
    final xfile = XFile.fromData(
      bytes,
      mimeType: 'image/png',
      name: 'poop_image_${DateTime.now().microsecondsSinceEpoch}.png',
    );

    // provider에 저장
    ref.read(cameraImagePickerProvider.notifier).set(xfile);
    ref.read(cameraUploadButtonProvider.notifier).set(true);
    // 뒤로가기
    await goBack();
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
          if (didPop) {
            return;
          }
          fnInvalidateCameraState();
          goBack();
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

              // 카메라 실행 취소 버튼
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

              // 사진 버튼 영역
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
                          fnGetImage(ImageSource.gallery, from: 'camera_web_screen');
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
