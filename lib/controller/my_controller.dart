import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';

mixin class MyController {
  late final WidgetRef myRef;
  late final BuildContext myContext;

  void fnInitMyController(WidgetRef ref, BuildContext context) {
    myRef = ref;
    myContext = context;
  }

  void fnInitMyProfileUpdateState() {
    myRef.invalidate(myProfileSexButtonProvider);
    myRef.invalidate(myProfileInterestButtonProvider);
    myRef.invalidate(myProfileUpdateButtonProvider);
    myRef.invalidate(myProfileInputProvider);
  }

  // 마이페이지 - 회사정보섹션 높이 변수
  double companySectionHeight = 0.0;

  // 계정정보수정 화면에서 사용하는 변수들
  final String maleCode = 'M';
  final String femaleCode = 'F';

  // 계정정보수정 화면에서 사용할 입력 컨트롤러
  TextEditingController birthInputController = TextEditingController();
  TextEditingController phoneInputController = TextEditingController();

  final List<Map<String, dynamic>> interests = [
    {'text' : '변관리', 'width': 100},
    {'text' : '활동관리', 'width': 110},
    {'text' : '수면관리', 'width': 110},
    {'text' : '디지털 반려동물 키우기', 'width': 350},
  ];

  bool fnCheckSex(String sex) {
    bool result = false;

    if(sex == 'F' || sex == 'M') result = true;

    return result;
  }

  bool fnCheckBirth(String birth) {
    bool result = false;

    if(birth != '' && birth.length == 10) result = true;

    return result;
  }

  bool fnCheckInterest(String interest) {
    bool result = false;

    if(interest != '') result = true;

    return result;
  }

  bool fnCheckPhoneNumber(String phone_number) {
    bool result = false;

    if(phone_number != '' || phone_number.length >= 13) result = true;

    return result;
  }

  Future<void> fnMyProfileUpdateExec() async {
    final String sex = myRef.read(myProfileInputProvider.notifier).getSex();
    final String birth = myRef.read(myProfileInputProvider.notifier).getBirth();
    final String interest = myRef.read(myProfileInputProvider.notifier).getInterest();
    final String phone_number = myRef.read(myProfileInputProvider.notifier).getPhoneNumber();

    debugPrint(sex);
    debugPrint(birth);
    debugPrint(interest);
    debugPrint(phone_number);

    if(!fnCheckSex(sex)) {
      // TODO : 오류 알림
      return;
    }
    if(!fnCheckBirth(birth)) {
      // TODO : 오류 알림
      return;
    }
    if(!fnCheckInterest(interest)) {
      // TODO : 오류 알림
      return;
    }
    if(!fnCheckPhoneNumber(phone_number)) {
      // TODO : 오류 알림
      return;
    }
  }
}
