import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CameraUploadButtonState extends StateNotifier<bool> {
  CameraUploadButtonState() : super(false);

  void activate(XFile? xfile) {
    if(xfile != null) {
      state = true;
    } else {
      state = false;
    }
  }

  void set(bool btnState) => state = btnState;

  bool get() => state;
}

final cameraUploadButtonProvider = 
    StateNotifierProvider<CameraUploadButtonState, bool>((ref) => CameraUploadButtonState());