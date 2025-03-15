import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/common/utils/fn_get_size.dart';

mixin class MyController {
  GlobalKey sectionKey1 = GlobalKey();
  GlobalKey sectionKey2 = GlobalKey();
  GlobalKey sectionKey3 = GlobalKey();

  double companySectionHeight = 0.0;
}
