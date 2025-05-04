import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CameraImagePickerState extends StateNotifier<XFile?> {
  CameraImagePickerState() : super(null);

  void set(XFile? xfile) => state = xfile;

  XFile? get() => state;
}

final cameraImagePickerProvider = 
  StateNotifierProvider<CameraImagePickerState, XFile?>((ref) => CameraImagePickerState());