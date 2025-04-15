import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';

double fnGetDeviceWidth(BuildContext context) {
  double webWidth = kIsWeb ? 
                      (MediaQuery.of(context).size.width >= ProjectConstant.WEB_MAX_WIDTH ? 
                        ProjectConstant.WEB_MAX_WIDTH : 
                        MediaQuery.of(context).size.width
                      ) : 
                      MediaQuery.of(context).size.width;
  
  return webWidth;
}