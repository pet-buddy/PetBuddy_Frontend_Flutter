import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
import 'package:path/path.dart' as p;

mixin class CustomCameraController {
  late final WidgetRef cameraRef;
  late final BuildContext cameraContext;

  void fnInitCameraController(WidgetRef ref, BuildContext context) {
    cameraRef = ref;
    cameraContext = context;
  }

  void fnInitCameraUploadScreen() {
    cameraRef.read(cameraImagePickerProvider.notifier).set(null);
    cameraRef.read(cameraUploadButtonProvider.notifier).set(false);
  }

  void fnInitCameraScreen() {
    cameraRef.read(cameraControllerProvider.notifier).set(null);
    cameraRef.read(cameraFlashProvider.notifier).set(FlashMode.off);
  }

  void fnInvalidateCameraUploadState() {
    cameraRef.invalidate(cameraImagePickerProvider);
    cameraRef.invalidate(cameraUploadButtonProvider);
  }

  void fnInvalidateCameraState() {
    cameraRef.invalidate(cameraControllerProvider);
    cameraRef.invalidate(cameraFlashProvider);
  }

  // XFile? _image;
  final ImagePicker picker = ImagePicker();

  Future<XFile?> fnGetImage(ImageSource imageSource, {String? from}) async {
    try {
      debugPrint("========== fnGetImage ==========");
      final XFile? pickedFile = await picker.pickImage(source: imageSource);
      
      if (pickedFile != null) {
        /* setState(() {
          _image = XFile(pickedFile.path);
        }); */
        debugPrint("========== pickedFile is not null ==========");
        cameraRef.read(cameraImagePickerProvider.notifier).set(pickedFile);
        cameraRef.read(cameraUploadButtonProvider.notifier).set(true);

        if(from != null) {
          if (cameraContext.mounted) {
            cameraContext.pop();
          }
        }
      }
    } catch (e) {
      debugPrint('Error get image: $e');
    }

    return cameraRef.read(cameraImagePickerProvider.notifier).get();
  }

  Future<void> fnUploadExec() async {
    final XFile? xfile = cameraRef.read(cameraImagePickerProvider.notifier).get();

    if(xfile == null) {
      showAlertDialog(
        context: cameraContext, 
        middleText: Sentence.UPLOAD_ERR_EMPTY,
      );
    } 

    // TODO : 반려동물 변 사진 업로드
  }

  Future<void> fnTakePicturesExec() async {
    final cameraControllerState = cameraRef.read(cameraControllerProvider);
    debugPrint("=========== fnTakePicturesExec Start ===========");
    
    if (cameraControllerState != null && cameraControllerState.value.isInitialized) {
      debugPrint("=========== cameraControllerState is not null ===========");

      final image = await cameraControllerState.takePicture();

      // 저장 경로 지정
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'captured_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = p.join(directory.path, fileName);

      // 복사해서 저장
      final savedFile = await File(image.path).copy(savedPath);

      cameraRef.read(cameraImagePickerProvider.notifier).set(XFile(savedPath));
      cameraRef.read(cameraUploadButtonProvider.notifier).set(true);

      // 결과 화면으로 이동
      if (cameraContext.mounted) {
        cameraContext.pop();
      }
    }
  }
  
}


