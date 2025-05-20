import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';

class CameraUploadScreen extends ConsumerStatefulWidget {
  const CameraUploadScreen({super.key});

  @override
  ConsumerState<CameraUploadScreen> createState() => CameraUploadScreenState();
}

class CameraUploadScreenState extends ConsumerState<CameraUploadScreen> with CustomCameraController {

  @override
  void initState() {
    super.initState();
    fnInitCameraController(ref, context);
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // 화면 상태 초기화
      fnInitCameraUploadScreen();  

      // if(!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      //   // 카메라 호출
      //   // fnGetImage(ImageSource.camera);

      //   // 카메라 화면 이동
      //   context.pushNamed('camera_screen');
      // } else {
      //   final userAgent = html.window.navigator.userAgent;
      //   // 모바일 기기의 웹 브라우저 앱에서 호출 시
      //   if (userAgent.contains("Android") || 
      //       userAgent.contains('iPhone') || 
      //       userAgent.contains('iPad')) {
      //     context.pushNamed('camera_web_screen');
      //     // fnTakePictureWeb();
      //   } 
      // }

      fnCallCameraScreen(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cameraImagePickerState = ref.watch(cameraImagePickerProvider);
    final cameraUploadButtonState = ref.watch(cameraUploadButtonProvider);

    return DefaultLayout(
      appBar: const DefaultAppBar(
        title: '사진 업로드',
        leadingDisable: true,
        actionDisable: true,
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          fnInvalidateCameraState();
          await fnClose(context);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  cameraImagePickerState != null ?
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: uploadContainerHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(uploadContainerRadius + 1),),
                        border: Border.all(
                              width: 1,
                              color: CustomColor.gray02,
                          ),
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: uploadContainerHeight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(uploadContainerRadius),
                              child: kIsWeb ?
                                Image.network(
                                  cameraImagePickerState.path,
                                  fit: BoxFit.cover,
                                ) :
                                Image.file(
                                  File(cameraImagePickerState.path),
                                  fit: BoxFit.cover,
                                ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                margin: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: CustomColor.white,
                                  borderRadius: BorderRadius.all(Radius.circular(24),),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    ref.read(cameraImagePickerProvider.notifier).set(null);
                                    ref.read(cameraUploadButtonProvider.notifier).set(false);
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/action/delete_circle.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ), 
                    ) :
                    GestureDetector(
                      onTap: () {
                        // 바깥영역도 갤러리 호출할지 논의 필요
                        // fnGetImage(ImageSource.gallery);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: uploadContainerHeight, 
                        decoration: BoxDecoration(
                          color: CustomColor.white,
                          borderRadius: BorderRadius.all(Radius.circular(uploadContainerRadius),),
                          border: Border.all(
                              width: 1,
                              color: CustomColor.gray02,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: fnGetDeviceWidth(context) * 0.6,
                              child: DefaultIconButton(
                                disabled: false,
                                onPressed: () {
                                  fnGetImage(ImageSource.gallery);
                                }, 
                                text: '사진 가져오기',
                                borderRadius: 20,
                                backgroundColor: CustomColor.yellow03,
                                borderColor: CustomColor.yellow03,
                                elevation: 4,
                                svgPicture: SvgPicture.asset(
                                  'assets/icons/photo/add_media_image.svg',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 16,),
                  DefaultTextButton(
                    disabled: !cameraUploadButtonState,
                    onPressed: () {
                      fnUploadExec();
                    }, 
                    text: '사진 업로드',
                    disalbedTextColor: const Color(0xFF5C5B5E),
                    borderRadius: 20,
                    elevation: 4,
                  ),
                  const SizedBox(height: 16,),
                  DefaultTextButton(
                    disabled: false,
                    onPressed: () {
                      fnCallCameraScreen(context, mode: "method_call");
                    }, 
                    text: '사진 촬영하기',
                    borderRadius: 20,
                    backgroundColor: CustomColor.blue04,
                    borderColor: CustomColor.blue04,
                    textColor: CustomColor.white,
                    elevation: 4,
                  ),
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
