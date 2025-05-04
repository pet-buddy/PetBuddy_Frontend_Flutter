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

  void fnInvalidateMyProfileUpdateState() {
    myRef.invalidate(myProfileSexButtonProvider);
    myRef.invalidate(myProfileInterestButtonProvider);
    myRef.invalidate(myProfileUpdateButtonProvider);
    myRef.invalidate(myProfileInputProvider);
  }

  void fnInvalidateMyPetAddState() {
    myRef.invalidate(myPetAddTypeFilterProvider);
    myRef.invalidate(myPetAddTypeDropdownProvider);
    myRef.invalidate(myPetAddFeedFilterProvider);
    myRef.invalidate(myPetAddFeedDropdownProvider);
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
  List<String> totalPetTypes = ['푸들', '포메라니안', '말티즈', '시추', '요크셔테리어', '골든리트리버', '래브라도리트리버', '비글', '보더콜리', '불독',
                                '치와와', '코커스패니얼', '닥스훈트'];
  // List<String> filteredPetTypes = [];
  List<String> totalPetFeeds = ['사료1', '사료2', '사료3', '사료4', '사료5', '사료6', '사료7', '사료8', '잘 모르겠어요'];

  List<String> leftoverFeed = ['50% 이상', '11~50%', '10% 이하'];

  TextEditingController petNameInputController = TextEditingController();
  TextEditingController petTypeInputController = TextEditingController();
  TextEditingController petFeedInputController = TextEditingController();
  TextEditingController petBirthInputController = TextEditingController();

  ScrollController petTypeScrollController = ScrollController();
  ScrollController petFeedScrollController = ScrollController();

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

  void fnGetFilteredPetFeedItems(String input) {
    myRef.read(myPetAddFeedFilterProvider.notifier).set(
      totalPetFeeds
        .where((item) => item.contains(input))
        .toList()
    );

    myRef.read(myPetAddFeedDropdownProvider.notifier).set(true);
  }

  void fnGetAllPetFeedItems() {
    myRef.read(myPetAddFeedFilterProvider.notifier).set(
      List.from(totalPetFeeds)
    );

    myRef.read(myPetAddFeedDropdownProvider.notifier).set(true);
  }

  void fnSelectPetFeedItems(String selected) {
    petFeedInputController.text = selected;

    myRef.read(myPetAddFeedDropdownProvider.notifier).set(false);
  }


  Future<void> fnLoginOutExec(WidgetRef ref, BuildContext context) async {
    final storage = ref.watch(secureStorageProvider);

    await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: null);
    await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: null);

    if(!context.mounted) return;
    context.goNamed('login_screen');
  }
}

  

