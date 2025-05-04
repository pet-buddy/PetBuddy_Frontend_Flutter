import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_color.dart';
import 'package:petbuddy_frontend_flutter/common/layout/default_appbar.dart';
import 'package:petbuddy_frontend_flutter/common/layout/default_layout.dart';
import 'package:petbuddy_frontend_flutter/controller/custom_camera_controller.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => CameraScreenState();
}

class CameraScreenState extends ConsumerState<CameraScreen> with CustomCameraController {
  @override
  void initState() {
    super.initState();
    fnInitCameraController(ref, context);
    ref.read(cameraControllerProvider.notifier).initCamera();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cameraControllerState = ref.watch(cameraControllerProvider);
    final cameraFlashState = ref.watch(cameraFlashProvider);

    return DefaultLayout(
      appBar: DefaultAppBar(
        title: '촬영',
        leadingOnPressed: () {
          if(!context.mounted) return;
          fnInvalidateCameraState();
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
          fnInvalidateCameraState();
          context.pop();
        },
        child: SafeArea(
          child: Column(
            children: [
              // 카메라 프리뷰
              Expanded(
                child: cameraControllerState != null && cameraControllerState.value.isInitialized
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          CameraPreview(cameraControllerState),
                          // 가이드 프레임
                          Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              border: Border.all(color: CustomColor.white.withValues(alpha: 0.5), width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
        
              // 하단 버튼
              Container(
                color: CustomColor.white,
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.photo_library),
                          onPressed: () {
                            // 갤러리에서 불러오기
                            fnGetImage(ImageSource.gallery, from: 'camera_screen');
                          },
                        ),
                        const SizedBox(width: 40),
                        GestureDetector(
                          onTap: () async {
                            fnTakePicturesExec();
                          },
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: CustomColor.blue03, width: 4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        IconButton(
                          icon: Icon(cameraFlashState == FlashMode.torch ? Icons.flash_on : Icons.flash_off),
                          onPressed: () {
                            // 플래시 토글
                            ref.read(cameraControllerProvider.notifier).toggleFlash(cameraRef);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
