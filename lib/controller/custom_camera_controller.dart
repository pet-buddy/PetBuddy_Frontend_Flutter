import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
import 'package:path/path.dart' as p;
import 'package:universal_html/html.dart' as html;
import 'package:http_parser/http_parser.dart';

mixin class CustomCameraController {
  late final WidgetRef cameraRef;
  late final BuildContext cameraContext;

  final double uploadContainerHeight = 400;
  final double uploadContainerRadius = 24;

  void fnInitCameraController(WidgetRef ref, BuildContext context) {
    cameraRef = ref;
    cameraContext = context;
  }

  void fnInitCameraUploadScreen() {
    cameraRef.read(cameraImagePickerProvider.notifier).set(null);
    cameraRef.read(cameraUploadButtonProvider.notifier).set(false);
  }

  void fnInitCameraScreen() {
    cameraRef.read(cameraControllerProvider.notifier).set(null);
    cameraRef.read(cameraFlashProvider.notifier).set(FlashMode.off);
  }

  void fnInvalidateCameraUploadState() {
    cameraRef.invalidate(cameraImagePickerProvider);
    cameraRef.invalidate(cameraUploadButtonProvider);
  }

  void fnInvalidateCameraState() {
    cameraRef.invalidate(cameraControllerProvider);
    cameraRef.invalidate(cameraFlashProvider);
  }

  // XFile? _image;
  final ImagePicker picker = ImagePicker();

  Future<XFile?> fnGetImage(ImageSource imageSource, {String? from}) async {
    try {
      // debugPrint("========== fnGetImage ==========");
      final XFile? pickedFile = await picker.pickImage(source: imageSource);
      
      if (pickedFile != null) {
        /* setState(() {
          _image = XFile(pickedFile.path);
        }); */
        // debugPrint("========== pickedFile is not null ==========");
        cameraRef.read(cameraImagePickerProvider.notifier).set(pickedFile);
        cameraRef.read(cameraUploadButtonProvider.notifier).set(true);

        if(from != null) {
          if (cameraContext.mounted) {
            cameraContext.pop();
          }
        }
      }
    } catch (e) {
      // debugPrint('==================== Error get image ====================');
      // debugPrint('$e');
    }

    return cameraRef.read(cameraImagePickerProvider.notifier).get();
  }

  MediaType fnGetMimeType(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();

    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      default:
        return MediaType('application', 'octet-stream'); // fallback
    }
  }

  Future<void> fnPredictImageExec() async {
    // TODO : 반려동물 수 체크 주석해제
    // int totalPets = cameraRef.read(responseDogsProvider.notifier).get().length;

    // if(totalPets <= 0) {
    //   showAlertDialog(
    //     context: cameraContext, 
    //     middleText: "반려동물을 먼저 등록해주세요!",
    //   );
    //   return;
    // }

    final XFile? xfile = cameraRef.read(cameraImagePickerProvider.notifier).get();

    if(xfile == null) {
      showAlertDialog(
        context: cameraContext, 
        middleText: Sentence.UPLOAD_ERR_EMPTY,
      );
      return;
    } 

    final dio = Dio();
    // 로딩바 출력 시작
    showLoadingDialog(context: cameraContext);

    try {
      
      final mimeType = fnGetMimeType(xfile.name);

      MultipartFile multipartFile = kIsWeb ? 
        MultipartFile.fromBytes(
          await xfile.readAsBytes(),
          filename: xfile.name,
          contentType: mimeType,
        ) :
        await MultipartFile.fromFile(
          xfile.path,
          filename: xfile.name,
          contentType: mimeType,
        );

      // debugPrint(xfile.path);
      // debugPrint(xfile.name);
      // debugPrint(multipartFile.toString());

      // dynamic formData =  FormData.fromMap({'arr': 
      //   kIsWeb ? MultipartFile.fromBytes(await xfile!.readAsBytes(),) : await MultipartFile.fromFile(xfile!.path), 
      //   'annotat': {}
      // });

      FormData formData = FormData.fromMap({
        'arr':multipartFile,
        'annotat':jsonEncode({}),
      });

      // 반려동물 변 사진 업로드
      final resp = await dio.post(
        '${ProjectConstant.POO_AI_URL}predict_image',
        options: Options(
          headers: {
            'accept': 'application/json',
            // 'Content-Type': 'multipart/form-data',
          },
          validateStatus: (status) => true,
        ),
        data: formData,
      );

      // debugPrint(resp.data.toString());

      // showAlertDialog(
      //   context: cameraContext, 
      //   middleText: resp.data.toString()
      // );

      // 똥 AI 분석 결과 변수에 저장
      List<double> poopScores = resp.data[0];
      // 똥 AI 분석 결과 Provider에 저장
      cameraRef.refresh(responsePoopScoreListProvider.notifier).set(poopScores);
      
      if(!cameraContext.mounted) return;
      // 로딩바 해제
      hideLoadingDialog(cameraContext);

    } catch(e) {
      // debugPrint('=================== $e');

      if(!cameraContext.mounted) return;
      // 로딩바 해제
      hideLoadingDialog(cameraContext);
      // 에러 알림창
      showAlertDialog(
        context: cameraContext, 
        middleText: e.toString()
      );
    }
  }

  Future<void> fnTakePicturesExec() async {
    final cameraControllerState = cameraRef.read(cameraControllerProvider);
    // debugPrint("=========== fnTakePicturesExec Start ===========");
    
    if (cameraControllerState != null && cameraControllerState.value.isInitialized) {
      // debugPrint("=========== cameraControllerState is not null ===========");

      final image = await cameraControllerState.takePicture();

      // 저장 경로 지정
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'captured_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedPath = p.join(directory.path, fileName);

      // 복사해서 저장
      final savedFile = await File(image.path).copy(savedPath);

      cameraRef.read(cameraImagePickerProvider.notifier).set(XFile(savedPath));
      cameraRef.read(cameraUploadButtonProvider.notifier).set(true);

      // 결과 화면으로 이동
      if (cameraContext.mounted) {
        cameraContext.pop();
      }
    }
  }
  
  Future<void> fnTakePictureWeb() async {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.setAttribute('capture', 'environment');
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final file = files.first;
        final reader = html.FileReader();

        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen((event) async {
          final imageUrl = reader.result as String;
          
          // debugPrint(imageUrl);
        });
      }
    });
  }

  void fnCallCameraScreen(BuildContext context, {String mode = "init"}) {
    if(!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        // 카메라 호출
        // fnGetImage(ImageSource.camera);

        // 카메라 화면 이동
        context.pushNamed('camera_screen');
    } else {
      final userAgent = html.window.navigator.userAgent;
      // 모바일 기기의 웹 브라우저 앱에서 호출 시
      if (userAgent.contains("Android") || 
          userAgent.contains('iPhone') || 
          userAgent.contains('iPad')) {
        context.pushNamed('camera_web_screen');
        // fnTakePictureWeb();
      } else {
        if(mode == 'init') {return;}
        else {
          showAlertDialog(
            context: context, 
            middleText: Sentence.WEB_CAMERA_ERR_CALL,
          );
        }
      }
    }
  }

  Future<void> fnPoopUploadExec() async {
    List<double> poopScores = cameraRef.read(responsePoopScoreListProvider.notifier).get();

    final isPoopProb = poopScores[0];
    final isNotPoopProb = poopScores[1];

    if(isPoopProb - isNotPoopProb <= 0.1) {
      showAlertDialog(
        context: cameraContext, 
        middleText: "반려동물의 변 사진이 맞는지\n다시 확인해 주세요!",
      );
      return;
    }

    final noParasite = poopScores[2];
    final yesParasite = poopScores[3];

    final isBlack = poopScores[4];
    final isBlood = poopScores[5];
    final isColorNormal = poopScores[6]; // (색상) 정상

    final isMoistureNormal = poopScores[7]; // (수분도) 정상
    final isConstipation = poopScores[8]; // 변비
    final isDiarrhea = poopScores[9]; // 설사

    final isRealBlack = poopScores[10];
    final isFakeBlack = poopScores[11];

    final XFile? xfile = cameraRef.read(cameraImagePickerProvider.notifier).get();
    final dio = Dio();

    int noParasiteScore = (noParasite * 100).round();
    int isColorNormalScore = (isColorNormal * 100).round();
    int isMoistureNormalScore = (isMoistureNormal * 100).round();
    int totalScore = ((noParasiteScore + isColorNormalScore + isMoistureNormalScore)/3).round();
          
    final mimeType = fnGetMimeType(xfile!.name);

    MultipartFile multipartFile = kIsWeb ? 
      MultipartFile.fromBytes(
        await xfile.readAsBytes(),
        filename: xfile.name,
        contentType: mimeType,
      ) :
      await MultipartFile.fromFile(
        xfile.path,
        filename: xfile.name,
        contentType: mimeType,
      );

    FormData formData = FormData.fromMap({
      'image':multipartFile,
      'poop_score_total': totalScore,
      'poop_score_grade':1,
      'poop_score_moisture': fnGetPoopStatus(isMoistureNormalScore),
      'poop_score_color': fnGetPoopStatus(isColorNormalScore),
      'poop_score_parasite': fnGetPoopStatus(noParasiteScore),
    });

    final resp = await dio.post(
      '${ProjectConstant.BASE_URL}poo/upload',
      options: Options(
        headers: {
          'accept': 'application/json',
        },
        validateStatus: (status) => true,
      ),
      data: formData,
    );

  } 

  String fnGetPoopStatus(int score) {
    String status = '';

    if(score >= 0 && score < 51) {
      status = 'C';
    } else if(score >= 50 && score < 71) {
      status = 'B';
    } else {
      status = 'A';
    }

    return status;
  }
}


