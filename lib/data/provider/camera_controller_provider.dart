import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:petbuddy_frontend_flutter/common/widget/dialog/alert_dialog.dart';
import 'package:petbuddy_frontend_flutter/data/data.dart';

final cameraControllerProvider = StateNotifierProvider<CameraControllerState, CameraController?>((ref) {
  return CameraControllerState();
});

class CameraControllerState extends StateNotifier<CameraController?> {
  CameraControllerState() : super(null);

  void set(CameraController? cameraController) => state = cameraController;

  CameraController? get() => state;  

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere((c) => c.lensDirection == CameraLensDirection.back);
    final controller = CameraController(frontCamera, ResolutionPreset.medium);
    await controller.initialize();
    state = controller;
  }

  Future<void> toggleFlash(WidgetRef ref, BuildContext context) async {
    if (state == null) return;
    final currentFlash = ref.read(cameraFlashProvider);
    final newFlash = currentFlash == FlashMode.off ? FlashMode.torch : FlashMode.off;
    try {
      await state!.setFlashMode(newFlash);
      ref.read(cameraFlashProvider.notifier).set(newFlash);
    } catch(e) {
      if(!context.mounted) return;
      showAlertDialog(
        context: context, 
        middleText: "해당 기기는 플래시 기능을 지원하지 않습니다.",
      );
    }
  }

  void disposeController() {
    state?.dispose();
    state = null;
  }
}
