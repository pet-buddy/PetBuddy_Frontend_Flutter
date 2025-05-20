import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/controller/custom_camera_controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/camera_controller_provider.dart';
import 'package:universal_html/html.dart' as html;

class CameraWebScreen extends ConsumerStatefulWidget {
  const CameraWebScreen({super.key});

  @override
  ConsumerState<CameraWebScreen> createState() => CameraWebScreenState();
}

class CameraWebScreenState extends ConsumerState<CameraWebScreen> with CustomCameraController {
  late html.VideoElement _videoElement;
  bool _cameraReady = false;
  String? _capturedImage;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
  _videoElement = html.VideoElement()
    ..autoplay = true
    ..muted = true
    ..setAttribute('playsinline', 'true')
    ..style.width = '100%'
    ..style.height = '100%'
    ..style.objectFit = 'cover';

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
    'camera-view',
    (int viewId) => _videoElement,
  );

  try {
    final stream = await html.window.navigator.mediaDevices?.getUserMedia({
      'video': {
        'facingMode': {'exact': 'environment'}, // ⬅️ 강한 후면카메라 요청
      },
      'audio': false,
    });

    if (stream != null) {
      _videoElement.srcObject = stream;
      await _videoElement.play();
      setState(() {
        _cameraReady = true;
      });
    }
  } catch (e) {
    print('후면카메라 실패, 전면카메라로 fallback 시도');
    try {
      final fallbackStream = await html.window.navigator.mediaDevices?.getUserMedia({
        'video': true, // 단순 요청
        'audio': false,
      });
      if (fallbackStream != null) {
        _videoElement.srcObject = fallbackStream;
        await _videoElement.play();
        setState(() {
          _cameraReady = true;
        });
      }
    } catch (e) {
      showAlertDialog(context: context, middleText: '카메라 접근 실패: $e');
    }
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

    print('📸 캡처된 base64 이미지: $dataUrl');
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
          fnInvalidateCameraState();
          context.pop();
        },
        child: SafeArea(
          child: _cameraReady ? Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 카메라 프리뷰
                const HtmlElementView(viewType: 'camera-view'),
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
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/etc/camera_close.svg',
                      width: 36,
                      height: 36,
                    ),
                    onPressed: () {
                      if(!context.mounted) return;
                      fnInvalidateCameraState();
                      context.pop();
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
                            // fnTakePicturesExec();
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
                          onPressed: () {
                            // 플래시 토글
                            ref.read(cameraControllerProvider.notifier).toggleFlash(cameraRef);
                          },
                        ),
                      ],
                    ),
                  )
                ),
              ],
            )
          ) : const Center(
                child: CircularProgressIndicator(
                  color: CustomColor.blue03,
                ),
              ),
        ),
      ),
    );
  }
}
