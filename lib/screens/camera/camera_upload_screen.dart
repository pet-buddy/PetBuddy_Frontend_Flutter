import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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

      if(!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        // 카메라 호출
        // fnGetImage(ImageSource.camera);

        // 카메라 화면 이동
        context.pushNamed('camera_screen');
      }
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                cameraImagePickerState != null ?
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12),),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
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
                      fnGetImage(ImageSource.gallery);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300, 
                      decoration: BoxDecoration(
                        color: CustomColor.white,
                        borderRadius: const BorderRadius.all(Radius.circular(12),),
                        border: Border.all(
                            width: 1,
                            color: CustomColor.gray04,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/photo/add_media_image.svg',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 4,),
                          Text(
                            '사진 가져오기',
                            style: CustomText.caption2.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          )
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
                ),
                const SizedBox(height: 32,),
              ],
            )
          ),
        ),
      ),
    );
  }
}
