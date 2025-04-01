import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petbuddy_frontend_flutter/controller/controller.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';


class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => CameraScreenState();
}

class CameraScreenState extends ConsumerState<CameraScreen> with CameraController {

  @override
  void initState() {
    super.initState();
    fnInitCameraController(ref, context);
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final imagePickerState = ref.watch(imagePickerProvider);

    return DefaultLayout(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          await fnClose(context);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  imagePickerState != null ?
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: Image.file(File(imagePickerState.path)), 
                    ) :
                    const SizedBox(
                      width: 300,
                      height: 300, 
                    ),
                  OutlinedButton(
                    onPressed: () {
                      fnGetImage(ImageSource.camera);
                    }, 
                    child: const Text('사진찍기'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      fnGetImage(ImageSource.gallery);
                    }, 
                    child: const Text('사진가져오기'),
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
