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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                imagePickerState != null ?
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12),),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.file(
                        File(imagePickerState.path),
                        fit: BoxFit.cover,
                      ),
                    ), 
                  ) :
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300, 
                    decoration: const BoxDecoration(
                      color: CustomColor.gray05,
                      borderRadius: BorderRadius.all(Radius.circular(12),),
                    ),
                  ),
                const SizedBox(height: 8,),
                DefaultTextButton(
                  disabled: false,
                  backgroundColor: CustomColor.yellow05,
                  borderColor: CustomColor.yellow05,
                  onPressed: () {
                    fnGetImage(ImageSource.gallery);
                  }, 
                  text: '사진 가져오기',
                ),
                const SizedBox(height: 8,),
                DefaultTextButton(
                  disabled: false,
                  backgroundColor: CustomColor.blue05,
                  borderColor: CustomColor.blue05,
                  textColor: CustomColor.white,
                  onPressed: () {
                    fnGetImage(ImageSource.camera);
                  }, 
                  text: '사진 촬영하기',
                ),
                const Spacer(),
                DefaultTextButton(
                  disabled: false,
                  backgroundColor: CustomColor.white,
                  borderColor: CustomColor.black,
                  textColor: CustomColor.black,
                  onPressed: () {
                    
                  }, 
                  text: '+ 사진 업로드',
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
