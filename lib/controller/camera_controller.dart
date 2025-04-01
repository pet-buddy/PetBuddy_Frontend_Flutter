import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petbuddy_frontend_flutter/data/provider/image_picker_provider.dart';

mixin class CameraController {
  late final WidgetRef cameraRef;
  late final BuildContext cameraContext;

  void fnInitCameraController(WidgetRef ref, BuildContext context) {
    cameraRef = ref;
    cameraContext = context;
  }

  // XFile? _image;
  final ImagePicker picker = ImagePicker();

  Future<XFile?> fnGetImage(ImageSource imageSource) async {
    try {
      debugPrint("1");
      final XFile? pickedFile = await picker.pickImage(source: imageSource);
      debugPrint("2");
      if (pickedFile != null) {
        /* setState(() {
          _image = XFile(pickedFile.path);
        }); */
        debugPrint("3");
        cameraRef.read(imagePickerProvider.notifier).set(pickedFile);
      }
    } catch (e) {
      debugPrint('Error get image: $e');
    }

    return cameraRef.read(imagePickerProvider.notifier).get();
  }
}


