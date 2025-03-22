import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin class MyController {
  // 마이페이지 - 회사정보섹션 높이를 구하기 위한 섹션별 키 
  GlobalKey sectionKey1 = GlobalKey();
  GlobalKey sectionKey2 = GlobalKey();
  GlobalKey sectionKey3 = GlobalKey();
  // 마이페이지 - 회사정보섹션 높이 변수
  double companySectionHeight = 0.0;

}
