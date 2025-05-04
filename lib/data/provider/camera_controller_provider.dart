import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
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

  Future<void> toggleFlash(WidgetRef ref) async {
    if (state == null) return;
    final currentFlash = ref.read(cameraFlashProvider);
    final newFlash = currentFlash == FlashMode.off ? FlashMode.torch : FlashMode.off;
    await state!.setFlashMode(newFlash);
    ref.read(cameraFlashProvider.notifier).set(newFlash);
  }

  void disposeController() {
    state?.dispose();
    state = null;
  }
}
