import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/provider/my_profile_input_provider.dart';

mixin class MyController {
  late final WidgetRef myRef;
  late final BuildContext myContext;

  void fnInitMyController(WidgetRef ref, BuildContext context) {
    myRef = ref;
    myContext = context;
  }

  // 마이페이지 - 회사정보섹션 높이를 구하기 위한 섹션별 키 
  GlobalKey sectionKey1 = GlobalKey();
  GlobalKey sectionKey2 = GlobalKey();
  GlobalKey sectionKey3 = GlobalKey();
  // 마이페이지 - 회사정보섹션 높이 변수
  double companySectionHeight = 0.0;

  // 계정정보수정 화면에서 사용하는 변수들
  final String maleCode = 'M';
  final String femaleCode = 'F';

  // 계정정보수정 화면에서 사용할 입력 컨트롤러
  TextEditingController birthInputController = TextEditingController();
  TextEditingController phoneInputController = TextEditingController();

  final List<Map<String, dynamic>> healthInfos = [
    {'text' : '변관리', 'width': 100},
    {'text' : '활동관리', 'width': 120},
    {'text' : '수면관리', 'width': 120},
    {'text' : '디지털 반려동물 키우기', 'width': 350},
  ];

  bool fnCheckGender(String gender) {
    bool result = false;

    if(gender == 'F' || gender == 'M') result = true;

    return result;
  }

  bool fnCheckBirth(String birth) {
    bool result = false;

    if(birth != '' && birth.length == 10) result = true;

    return result;
  }

  bool fnCheckHealthInfo(String healthInfo) {
    bool result = false;

    if(healthInfo != '') result = true;

    return result;
  }

  bool fnCheckPhone(String phone) {
    bool result = false;

    if(phone != '' || phone.length >= 13) result = true;

    return result;
  }

  Future<void> fnMyProfileUpdateExec() async {
    final String gender = myRef.read(myProfileInputProvider.notifier).getGender();
    final String birth = myRef.read(myProfileInputProvider.notifier).getBirth();
    final String healthInfo = myRef.read(myProfileInputProvider.notifier).getHealthInfo();
    final String phone = myRef.read(myProfileInputProvider.notifier).getPhone();

    debugPrint(gender);
    debugPrint(birth);
    debugPrint(healthInfo);
    debugPrint(phone);

    if(!fnCheckGender(gender)) {
      // TODO : 오류 알림
      return;
    }
    if(!fnCheckBirth(birth)) {
      // TODO : 오류 알림
      return;
    }
    if(!fnCheckHealthInfo(healthInfo)) {
      // TODO : 오류 알림
      return;
    }
    if(!fnCheckPhone(phone)) {
      // TODO : 오류 알림
      return;
    }
  }
}
