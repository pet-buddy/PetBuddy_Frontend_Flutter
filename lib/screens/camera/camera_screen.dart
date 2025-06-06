import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_color.dart';
import 'package:petbuddy_frontend_flutter/common/const/custom_text.dart';
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
      // appBar: DefaultAppBar(
      //   title: '촬영',
      //   leadingOnPressed: () {
      //     if(!context.mounted) return;
      //     fnInvalidateCameraState();
      //     context.pop();
      //   },
      //   actionDisable: true,
      // ),
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
          child: Expanded(
            child: cameraControllerState != null && cameraControllerState.value.isInitialized
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      // CameraPreview(cameraControllerState),
                      // 카메라 프리뷰
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return SizedBox(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            child: CameraPreview(cameraControllerState),
                          );
                        },
                      ),
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
                                  // color: const Color(0xFFFFF3D9).withValues(alpha: 0.6),
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
                                  fnTakePicturesExec();
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/etc/camera_button.svg',
                                  width: 64,
                                  height: 64,
                                ),
                              ),
                              const SizedBox(width: 40),
                              IconButton(
                                // icon: Icon(cameraFlashState == FlashMode.torch ? Icons.flash_on : Icons.flash_off),
                                icon: SvgPicture.asset(
                                  cameraFlashState == FlashMode.torch ? 
                                    'assets/icons/etc/camera_flash_off.svg' :
                                    'assets/icons/etc/camera_flash_on.svg',
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
                : const Center(
                    child: CircularProgressIndicator(
                      color: CustomColor.blue03,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
