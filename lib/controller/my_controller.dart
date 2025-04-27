import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/const/project_constant.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
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

  void fnInitMyPetAddState() {
    myRef.invalidate(myPetAddTypeFilterProvider);
    myRef.invalidate(myPetAddTypeDropdownProvider);
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

  // 반려동물 추가하기 관련 변수
  List<String> totalPetTypes = ['불독', '포메라니안', '기타 등등', '테스트1', '테스트2', '테스트3', '테스트4', '테스트5'];
  // List<String> filteredPetTypes = [];

  TextEditingController petNameInputController = TextEditingController();
  TextEditingController petTypeInputController = TextEditingController();
  TextEditingController petFeedInputController = TextEditingController();

  ScrollController petTypeScrollController = ScrollController();

  void fnGetFilteredPetTypeItems(String input) {
    myRef.read(myPetAddTypeFilterProvider.notifier).set(
      totalPetTypes
        .where((item) => item.contains(input))
        .toList()
    );

    myRef.read(myPetAddTypeDropdownProvider.notifier).set(true);
  }

  void fnGetAllPetTypeItems() {
    myRef.read(myPetAddTypeFilterProvider.notifier).set(
      List.from(totalPetTypes)
    );

    myRef.read(myPetAddTypeDropdownProvider.notifier).set(true);
  }

  void fnSelectPetTypeItems(String selected) {
    petTypeInputController.text = selected;

    myRef.read(myPetAddTypeDropdownProvider.notifier).set(false);
  }


  Future<void> fnLoginOutExec(WidgetRef ref, BuildContext context) async {
    final storage = ref.watch(secureStorageProvider);

    await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: null);
    await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: null);

    if(!context.mounted) return;
    context.goNamed('login_screen');
  }
}

  

