import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
import 'package:petbuddy_frontend_flutter/controller/controller_utils.dart';
import 'package:petbuddy_frontend_flutter/data/model/model.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
import 'package:petbuddy_frontend_flutter/data/repository/user_repository.dart';

mixin class MyController {
  late final WidgetRef myRef;
  late final BuildContext myContext;

  void fnInitMyController(WidgetRef ref, BuildContext context) {
    myRef = ref;
    myContext = context;
  }

  void fnInitMyProfileUpdateState() {
    final responseUserMypageState = myRef.read(responseUserMypageProvider.notifier).get();
    myRef.read(myProfileGenderButtonProvider.notifier).set(responseUserMypageState.gender ?? "");
    myRef.read(myProfileInterestButtonProvider.notifier).set(interestCode.indexOf(responseUserMypageState.interest ?? ""));
    birthInputController.text = responseUserMypageState.birth ?? "";
    phoneInputController.text = responseUserMypageState.phone_number ?? "";
    myRef.read(myProfileInputProvider.notifier).setGender(responseUserMypageState.gender ?? "");
    myRef.read(myProfileInputProvider.notifier).setBirth(responseUserMypageState.birth ?? "");
    myRef.read(myProfileInputProvider.notifier).setInterest(responseUserMypageState.interest ?? "");
    myRef.read(myProfileInputProvider.notifier).setPhoneNumber(responseUserMypageState.phone_number ?? "");

    myRef.read(myProfileUpdateButtonProvider.notifier)
         .activate(myRef.read(myProfileInputProvider.notifier).get());
  }

  void fnInvalidateMyProfileUpdateState() {
    myRef.invalidate(myProfileGenderButtonProvider);
    myRef.invalidate(myProfileInterestButtonProvider);
    myRef.invalidate(myProfileUpdateButtonProvider);
    myRef.invalidate(myProfileInputProvider);
  }

  void fnInvalidateMyPetAddState() {
    myRef.invalidate(myPetAddTypeFilterProvider);
    myRef.invalidate(myPetAddTypeDropdownProvider);
    myRef.invalidate(myPetAddFeedFilterProvider);
    myRef.invalidate(myPetAddFeedDropdownProvider);
    myRef.invalidate(myPetAddSizeButtonProvider);
    myRef.invalidate(myPetAddGenderButtonProvider);
    myRef.invalidate(myPetAddNeuterButtonProvider);
    myRef.invalidate(myPetAddFeedAmountButtonProvider);
  }

  // 마이페이지 - 회사정보섹션 높이 변수
  double companySectionHeight = 0.0;

  // 계정정보수정 화면에서 사용하는 변수들
  final String maleCode = 'MALE';
  final String femaleCode = 'FEMALE';

  final String largeSize = 'LARGE';
  final String mediumSize = 'MEDIUM';
  final String smallSize = 'SMALL';

  final String neuterY = 'Y';
  final String neuterN = 'N';

  final List<String> feedAmount = ['50%', '11~50%', '10%'];

  // 계정정보수정 화면에서 사용할 입력 컨트롤러
  TextEditingController birthInputController = TextEditingController();
  TextEditingController phoneInputController = TextEditingController();

  final List<Map<String, dynamic>> interests = [
    {'text' : '변관리', 'width': 100},
    {'text' : '활동관리', 'width': 110},
    {'text' : '수면관리', 'width': 110},
    {'text' : '디지털 반려동물 키우기', 'width': 350},
  ];

  final List<String> interestCode = ['POO', 'ACTIVITY', 'SLEEP', 'DIGITALPET'];

  bool fnCheckGender(String gender) {
    bool result = false;

    if(gender == femaleCode || gender == maleCode) result = true;

    if(!result) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.GENDER_ERR_EMPTY,
      );
    }

    return result;
  }

  bool fnCheckBirth(String birth) {
    bool result = false;

    if(birth.isEmpty) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.BIRTH_ERR_EMPTY,
      );
    } else if(birth.length != 10) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.BIRTH_ERR_LEN,
      );
    }

    if(birth != '' && birth.length == 10) result = true;

    return result;
  }

  bool fnCheckInterest(String interest) {
    bool result = false;

    if(interest != '') result = true;

    if(!result) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.INTEREST_ERR_EMPTY,
      );
    }

    return result;
  }

  bool fnCheckPhoneNumber(String phone_number) {
    bool result = false;

    if(phone_number.isEmpty) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PHONE_ERR_EMPTY,
      );
    } else if(phone_number.length < 13) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PHONE_ERR_LEN,
      );
    }

    if(phone_number != '' && phone_number.length >= 13) result = true;

    return result;
  }

  Future<void> fnMyProfileUpdateExec() async {
    final String gender = myRef.read(myProfileInputProvider.notifier).getGender();
    final String birth = myRef.read(myProfileInputProvider.notifier).getBirth();
    final String interest = myRef.read(myProfileInputProvider.notifier).getInterest();
    final String phone_number = myRef.read(myProfileInputProvider.notifier).getPhoneNumber();

    // debugPrint(gender);
    // debugPrint(birth);
    // debugPrint(interest);
    // debugPrint(phone_number);

    if(!fnCheckGender(gender)) {
      return;
    }
    if(!fnCheckBirth(birth)) {
      return;
    }
    if(!fnCheckInterest(interest)) {
      return;
    }
    if(!fnCheckPhoneNumber(phone_number)) {
      return;
    }
    // 로딩 시작
    showLoadingDialog(context: myContext);

    try {
      final response = await myRef.read(userRepositoryProvider).requestUsersRepository(
        RequestUsersModel(
          gender: gender, 
          interest: interest, 
          phone_number: phone_number, 
          birth: birth
        ),
      );

      if(response.response_code == 200) {
        ResponseUsersModel responseUsersModel = ResponseUsersModel.fromJson(response.data);

        await ControllerUtils.fnGetUserMypage(myRef);
        
        if(!myContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(myContext);
        // 성공 알림창
        showAlertDialog(
          context: myContext, 
          middleText: "계정 정보 변경이 완료되었습니다.",
          barrierDismissible: false,
          onConfirm: () {
            // 페이지 이동
            myContext.pop();
          }
        );
      } else {
        if(!myContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(myContext);
        // 에러 알림창
        showAlertDialog(
          context: myContext, 
          middleText: "계정 정보 수정에 실패했습니다."
        );
        return;
      }
    } on DioException catch(e) {
      debugPrint("========== Request Users Dio Exception ==========");
      debugPrint(e.toString());

      // 로딩 끝
      if(!myContext.mounted) return;
      hideLoadingDialog(myContext);

      // 에러 알림창
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.SERVER_ERR,
      );
    }
  }

  // 반려동물 추가하기 관련 변수
  // List<String> totalPetTypes = ['푸들', '포메라니안', '말티즈', '시추', '요크셔테리어', '골든리트리버', '래브라도리트리버', '비글', '보더콜리', '불독',
  //                               '치와와', '코커스패니얼', '닥스훈트'];
  // List<String> filteredPetTypes = [];
   List<MyBreedModel> totalPetTypes = [
      MyBreedModel(code: 'A001001푸들', breed: '[강아지] 푸들'),
      MyBreedModel(code: 'A001002포메라니안', breed: '[강아지] 포메라니안'),
      MyBreedModel(code: 'A001003말티즈', breed: '[강아지] 말티즈'),
      MyBreedModel(code: 'A001004시추', breed: '[강아지] 시추'),
      MyBreedModel(code: 'A001005요크셔테리어', breed: '[강아지] 요크셔테리어'),
      MyBreedModel(code: 'A001006골든리트리버', breed: '[강아지] 골든리트리버'),
      MyBreedModel(code: 'A001007래브라도리트리버', breed: '[강아지] 래브라도리트리버'),
      MyBreedModel(code: 'A001008비글', breed: '[강아지] 비글'),
      MyBreedModel(code: 'A001009보더콜리', breed: '[강아지] 보더콜리'),
      MyBreedModel(code: 'A001010불독', breed: '[강아지] 불독'),
      MyBreedModel(code: 'A001011치와와', breed: '[강아지] 치와와'),
      MyBreedModel(code: 'A001012코커스패니얼', breed: '[강아지] 코커스패니얼'),
      MyBreedModel(code: 'A001013닥스훈트', breed: '[강아지] 닥스훈트'),
      MyBreedModel(code: 'A001014셰퍼드', breed: '[강아지] 셰퍼드'),
      MyBreedModel(code: 'A001015도베르만', breed: '[강아지] 도베르만'),
      MyBreedModel(code: 'A001016사모예드', breed: '[강아지] 사모예드'),
      MyBreedModel(code: 'A001017웰시코기', breed: '[강아지] 웰시코기'),
      MyBreedModel(code: 'A001018아프간하운드', breed: '[강아지] 아프간하운드'),
      MyBreedModel(code: 'A001019달마시안', breed: '[강아지] 달마시안'),
      MyBreedModel(code: 'A001020그레이하운드', breed: '[강아지] 그레이하운드'),
      MyBreedModel(code: 'A002001코리안숏헤어', breed: '[고양이] 코리안숏헤어'),
      MyBreedModel(code: 'A002002러시안블루', breed: '[고양이] 러시안블루'),
      MyBreedModel(code: 'A002003샴', breed: '[고양이] 샴'),
      MyBreedModel(code: 'A002004스코티시폴드', breed: '[고양이] 스코티시폴드'),
      MyBreedModel(code: 'A002005브리티시숏헤어', breed: '[고양이] 브리티시숏헤어'),
      MyBreedModel(code: 'A002006뱅갈', breed: '[고양이] 뱅갈'),
      MyBreedModel(code: 'A002007메인쿤', breed: '[고양이] 메인쿤'),
      MyBreedModel(code: 'A002008터키시앙고라', breed: '[고양이] 터키시앙고라'),
      MyBreedModel(code: 'A002009노르웨이숲', breed: '[고양이] 노르웨이숲'),
      MyBreedModel(code: 'A002010페르시안', breed: '[고양이] 페르시안'),
      MyBreedModel(code: 'A002011아메리칸쇼트헤어', breed: '[고양이] 아메리칸쇼트헤어'),
      MyBreedModel(code: 'A002012랙돌', breed: '[고양이] 랙돌'),
      MyBreedModel(code: 'A002013버만', breed: '[고양이] 버만'),
      MyBreedModel(code: 'A002014싱가푸라', breed: '[고양이] 싱가푸라'),
      MyBreedModel(code: 'A002015소말리', breed: '[고양이] 소말리'),
      MyBreedModel(code: 'A002016스핑크스', breed: '[고양이] 스핑크스'),
      MyBreedModel(code: 'A002017아비시니안', breed: '[고양이] 아비시니안'),
      MyBreedModel(code: 'A002018히말라얀', breed: '[고양이] 히말라얀'),
      MyBreedModel(code: 'A002019셀커크렉스', breed: '[고양이] 셀커크렉스'),
      MyBreedModel(code: 'A002020오리엔탈숏헤어', breed: '[고양이] 오리엔탈숏헤어'),
   ];
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
        .where((item) => item.breed.contains(input))
        .map((item) => item.breed).toList(),
    );

    myRef.read(myPetAddTypeDropdownProvider.notifier).set(true);
  }

  void fnGetAllPetTypeItems() {
    myRef.read(myPetAddTypeFilterProvider.notifier).set(
      List.from(totalPetTypes.map((item) => item.breed))
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

    ref.invalidate(responseUserMypageProvider);

    if(!context.mounted) return;
    context.goNamed('login_screen');
  }
}

  

