import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
      appBar: const DefaultAppBar(
        title: '카메라',
        leadingDisable: true,
        actionDisable: true,
      ),
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
                const SizedBox(height: 16),
                imagePickerState != null ?
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12),),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.file(
                              File(imagePickerState.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              margin: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: CustomColor.white,
                                borderRadius: BorderRadius.all(Radius.circular(24),),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  ref.read(imagePickerProvider.notifier).set(null);
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/action/delete_circle.svg',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ), 
                  ) :
                  GestureDetector(
                    onTap: () {
                      fnGetImage(ImageSource.gallery);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300, 
                      decoration: BoxDecoration(
                        color: CustomColor.white,
                        borderRadius: const BorderRadius.all(Radius.circular(12),),
                        border: Border.all(
                            width: 1,
                            color: CustomColor.gray04,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/photo/add_media_image.svg',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 4,),
                          Text(
                            '사진 가져오기',
                            style: CustomText.caption2.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16,),
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
