import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraFlashState extends StateNotifier<FlashMode> {
  CameraFlashState() : super(FlashMode.off);

  void set(FlashMode flashMode) => state = flashMode;

  FlashMode get() => state;
}

final cameraFlashProvider = 
    StateNotifierProvider<CameraFlashState, FlashMode>((ref) => CameraFlashState());