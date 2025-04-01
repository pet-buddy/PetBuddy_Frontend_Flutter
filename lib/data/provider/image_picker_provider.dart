import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerState extends StateNotifier<XFile?> {
  ImagePickerState() : super(null);

  void set(XFile? xfile) => state = xfile;

  XFile? get() => state;
}

final imagePickerProvider = 
  StateNotifierProvider<ImagePickerState, XFile?>((ref) => ImagePickerState());