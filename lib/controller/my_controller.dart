import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petbuddy_frontend_flutter/common/common.dart';
import 'package:petbuddy_frontend_flutter/common/http/secure_storage.dart';
import 'package:petbuddy_frontend_flutter/controller/controller_utils.dart';
import 'package:petbuddy_frontend_flutter/data/model/model.dart';
import 'package:petbuddy_frontend_flutter/data/provider/provider.dart';
import 'package:petbuddy_frontend_flutter/data/repository/pet_repository.dart';
import 'package:petbuddy_frontend_flutter/data/repository/user_repository.dart';
import 'package:url_launcher/url_launcher.dart';

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
    myRef.read(requestUsersProvider.notifier).setGender(responseUserMypageState.gender ?? "");
    myRef.read(requestUsersProvider.notifier).setBirth(responseUserMypageState.birth ?? "");
    myRef.read(requestUsersProvider.notifier).setInterest(responseUserMypageState.interest ?? "");
    myRef.read(requestUsersProvider.notifier).setPhoneNumber(responseUserMypageState.phone_number ?? "");

    myRef.read(myProfileUpdateButtonProvider.notifier)
         .activate(myRef.read(requestUsersProvider.notifier).get());
  }

  void fnInvalidateMyProfileUpdateState() {
    myRef.invalidate(myProfileGenderButtonProvider);
    myRef.invalidate(myProfileInterestButtonProvider);
    myRef.invalidate(myProfileUpdateButtonProvider);
    myRef.invalidate(requestUsersProvider);
  }

  void fnInitMyPetAddState() {
    myRef.read(myPetAddTypeFilterProvider.notifier).set([]);
    myRef.read(myPetAddTypeDropdownProvider.notifier).set(false);
    myRef.read(myPetAddFeedFilterProvider.notifier).set([]);
    myRef.read(myPetAddFeedDropdownProvider.notifier).set(false);
    myRef.read(myPetAddSizeButtonProvider.notifier).set("");
    myRef.read(myPetAddGenderButtonProvider.notifier).set("");
    myRef.read(myPetAddNeuterButtonProvider.notifier).set("");
    myRef.read(myPetAddFeedAmountButtonProvider.notifier).set("");
    myRef.read(myPetAddNameInputStatusCodeProvider.notifier).set(ProjectConstant.INPUT_INIT);
    myRef.read(myPetAddBirthInputStatusCodeProvider.notifier).set(ProjectConstant.INPUT_INIT);
    myRef.read(requestNewDogProvider.notifier).set(
      RequestNewDogModel(
        pet_name: '',
        pet_size: '',
        division2_code: '',
        pet_gender: '',
        neuter_yn: null,
        feed_id: -1,
        feed_time: [],
        pet_birth: '',
        food_remain_grade: '',
      ),
    );
    myRef.read(requestUpdateDogProvider.notifier).set(
      RequestUpdateDogModel(
        pet_name: '',
        pet_size: '',
        division2_code: '',
        pet_gender: '',
        neuter_yn: null,
        feed_id: -1,
        feed_time: [],
        pet_birth: '',
        food_remain_grade: '',
      ),
    );
    myRef.read(myPetAddFeedTimeListProvider.notifier).set([]);
    myRef.read(myPetAddFeedTimeDeleteListProvider.notifier).set([]);
    myRef.read(myPetAddFeedTimeMeridiemButtonProvider.notifier).set("");
    myRef.read(myPetAddFeedTimeSelectModeProvider.notifier).set("");
    myRef.read(myPetAddButtonProvider.notifier).set(false);
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
    myRef.invalidate(myPetAddNameInputStatusCodeProvider);
    myRef.invalidate(myPetAddBirthInputStatusCodeProvider);
    myRef.invalidate(myPetAddFeedTimeListProvider);
    myRef.invalidate(myPetAddFeedTimeDeleteListProvider);
    myRef.invalidate(myPetAddFeedTimeMeridiemButtonProvider);
    myRef.invalidate(myPetAddFeedTimeSelectModeProvider);
    myRef.invalidate(requestNewDogProvider); // 반려동물 추가하기 모델
    myRef.invalidate(requestUpdateDogProvider); // 반려동물 수정하기 모델
    myRef.invalidate(myPetAddButtonProvider); // 반려동물 추가하기 버튼
  }

  void fnInvalidateMyPetUpdateState() {
    myRef.invalidate(myPetAddTypeFilterProvider);
    myRef.invalidate(myPetAddTypeDropdownProvider);
    myRef.invalidate(myPetAddFeedFilterProvider);
    myRef.invalidate(myPetAddFeedDropdownProvider);
    myRef.invalidate(myPetAddSizeButtonProvider);
    myRef.invalidate(myPetAddGenderButtonProvider);
    myRef.invalidate(myPetAddNeuterButtonProvider);
    myRef.invalidate(myPetAddFeedAmountButtonProvider);
    myRef.invalidate(myPetAddNameInputStatusCodeProvider);
    myRef.invalidate(myPetAddBirthInputStatusCodeProvider);
    myRef.invalidate(myPetAddFeedTimeListProvider);
    myRef.invalidate(myPetAddFeedTimeDeleteListProvider);
    myRef.invalidate(myPetAddFeedTimeMeridiemButtonProvider);
    myRef.invalidate(myPetAddFeedTimeSelectModeProvider);
    myRef.invalidate(requestNewDogProvider); // 반려동물 추가하기 모델
    myRef.invalidate(requestUpdateDogProvider); // 반려동물 수정하기 모델
    myRef.invalidate(myPetUpdateButtonProvider); // 반려동물 수정하기 버튼
  }

  void fnInvalidateCustomTimePickerDialogState() {
    myRef.invalidate(myPetAddFeedTimeMeridiemButtonProvider);
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

  String fnGetDogSizeKorName(String pet_size) {
    return pet_size == smallSize ? 
            '소형견' : 
            pet_size == mediumSize ?
              '중형견' : '대형견';
  }

  bool fnCheckGender(String gender) {
    bool result = false;

    if(gender == femaleCode || gender == maleCode) result = true;

    return result;
  }

  bool fnCheckBirth(String birth) {
    bool result = false;

    if(birth.isEmpty) {
      myRef.read(myProfileBirthInputStatusCodeProvider.notifier)
           .set(ProjectConstant.INPUT_ERR_EMPTY);
    } else if(birth.length != 10) {
      myRef.read(myProfileBirthInputStatusCodeProvider.notifier)
           .set(ProjectConstant.INPUT_ERR_LENGTH);
    }

    // if(birth != '' && birth.length == 10) {
    //   myRef.read(myProfileBirthInputStatusCodeProvider.notifier)
    //        .set(ProjectConstant.INPUT_SUCCESS);

    //   result = true;
    // }

    if(birth.length == 10) {
      bool formatResult = fnValidateBirthFormat(birth);
      if(!formatResult) {
        myRef.read(myProfileBirthInputStatusCodeProvider.notifier)
             .set(ProjectConstant.INPUT_ERR_FORMAT); 
        return result;
      } else {
        myRef.read(myProfileBirthInputStatusCodeProvider.notifier)
             .set(ProjectConstant.INPUT_SUCCESS);

        result = true;
      }
    }

    return result;
  }

  bool fnCheckInterest(String interest) {
    bool result = false;

    if(interest != '') result = true;

    return result;
  }

  bool fnCheckPhoneNumber(String phone_number) {
    bool result = false;

    if(phone_number.isEmpty) {
      myRef.read(myProfilePhoneNumberInputStatusCodeProvider.notifier)
           .set(ProjectConstant.INPUT_ERR_EMPTY);
    } else if(phone_number.length < 13) {
      myRef.read(myProfilePhoneNumberInputStatusCodeProvider.notifier)
           .set(ProjectConstant.INPUT_ERR_LENGTH);
    }

    if(phone_number != '' && phone_number.length >= 13) {
      myRef.read(myProfilePhoneNumberInputStatusCodeProvider.notifier)
           .set(ProjectConstant.INPUT_SUCCESS);

      result = true;
    }

    return result;
  }

  Future<void> fnMyProfileUpdateExec() async {
    final String gender = myRef.read(requestUsersProvider.notifier).getGender();
    final String birth = myRef.read(requestUsersProvider.notifier).getBirth();
    final String interest = myRef.read(requestUsersProvider.notifier).getInterest();
    final String phone_number = myRef.read(requestUsersProvider.notifier).getPhoneNumber();

    // debugPrint(gender);
    // debugPrint(birth);
    // debugPrint(interest);
    // debugPrint(phone_number);

    if(!fnCheckGender(gender)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.GENDER_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckBirth(birth)) {
      if(birth.isEmpty) {
        showAlertDialog(
          context: myContext, 
          middleText: Sentence.BIRTH_ERR_EMPTY,
        );
      } else if(birth.length != 10) {
        showAlertDialog(
          context: myContext, 
          middleText: Sentence.BIRTH_ERR_LENGTH,
        );
      } else if(birth.length == 10) {
        if(!fnValidateBirthFormat(birth)) {
          showAlertDialog(
            context: myContext, 
            middleText: Sentence.BIRTH_ERR_FORMAT,
          );
        }
      }
      return;
    }

    myRef.read(myProfileBirthInputStatusCodeProvider.notifier)
           .set(ProjectConstant.INPUT_SUCCESS);

    if(!fnCheckInterest(interest)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.INTEREST_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPhoneNumber(phone_number)) {
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
      return;
    }

    myRef.read(myProfilePhoneNumberInputStatusCodeProvider.notifier)
           .set(ProjectConstant.INPUT_SUCCESS);

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
        ResponseUsersModel responseUsersModel = ResponseUsersModel.fromJson(response.data!);

        if(!myContext.mounted) return;
        await ControllerUtils.fnGetUserMypageExec(myRef, myContext);

        if(!myContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(myContext);
        // 성공 알림창
        showAlertDialog(
          context: myContext, 
          middleText: "계정 정보가 수정되었습니다.",
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
          middleText: "계정 정보 수정이 실패했습니다.\n${response.response_message}"
        );
        return;
      }
    } on DioException catch(e) {
      // debugPrint("========== Request Users Dio Exception ==========");
      // debugPrint(e.toString());

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
  // TODO : 고양이 일러스트 완성 시 고양이 품종 주석 해제
  List<MyBreedModel> totalPetTypes = [
    MyBreedModel(code: 'A001001', breed: '[강아지] 푸들'),
    MyBreedModel(code: 'A001002', breed: '[강아지] 포메라니안'),
    MyBreedModel(code: 'A001003', breed: '[강아지] 말티즈'),
    MyBreedModel(code: 'A001004', breed: '[강아지] 시추'),
    MyBreedModel(code: 'A001005', breed: '[강아지] 요크셔테리어'),
    MyBreedModel(code: 'A001006', breed: '[강아지] 골든리트리버'),
    MyBreedModel(code: 'A001007', breed: '[강아지] 래브라도리트리버'),
    MyBreedModel(code: 'A001008', breed: '[강아지] 비글'),
    MyBreedModel(code: 'A001009', breed: '[강아지] 보더콜리'),
    MyBreedModel(code: 'A001010', breed: '[강아지] 불독'),
    MyBreedModel(code: 'A001011', breed: '[강아지] 치와와'),
    MyBreedModel(code: 'A001012', breed: '[강아지] 코커스패니얼'),
    MyBreedModel(code: 'A001013', breed: '[강아지] 닥스훈트'),
    MyBreedModel(code: 'A001014', breed: '[강아지] 셰퍼드'),
    MyBreedModel(code: 'A001015', breed: '[강아지] 도베르만'),
    MyBreedModel(code: 'A001016', breed: '[강아지] 사모예드'),
    MyBreedModel(code: 'A001017', breed: '[강아지] 웰시코기'),
    MyBreedModel(code: 'A001018', breed: '[강아지] 아프간하운드'),
    MyBreedModel(code: 'A001019', breed: '[강아지] 달마시안'),
    MyBreedModel(code: 'A001020', breed: '[강아지] 그레이하운드'),
    MyBreedModel(code: 'A001021', breed: '[강아지] 진돗개'),
    MyBreedModel(code: 'A001022', breed: '[강아지] 미니어처 불테리어'),
    // 견종 추가
    MyBreedModel(code: 'A001023', breed: '[강아지] 미니어처 슈나우저'),
    MyBreedModel(code: 'A001024', breed: '[강아지] 미니어처 핀셔'),
    MyBreedModel(code: 'A001025', breed: '[강아지] 바센지'),
    MyBreedModel(code: 'A001026', breed: '[강아지] 바셋 하운드'),
    MyBreedModel(code: 'A001027', breed: '[강아지] 버니즈 마운틴 도그'),
    MyBreedModel(code: 'A001028', breed: '[강아지] 베들링턴 테리어'),
    MyBreedModel(code: 'A001029', breed: '[강아지] 벨기에 말리노이즈'),
    MyBreedModel(code: 'A001030', breed: '[강아지] 벨기에 시프도그(그루넨달)'),
    MyBreedModel(code: 'A001031', breed: '[강아지] 벨기에 테뷰런'),
    MyBreedModel(code: 'A001032', breed: '[강아지] 브뤼셀 그리펀'),
    MyBreedModel(code: 'A001033', breed: '[강아지] 벨지안 셰퍼드 독'),
    MyBreedModel(code: 'A001034', breed: '[강아지] 보더 콜리'),
    MyBreedModel(code: 'A001035', breed: '[강아지] 보더 테리어'),
    MyBreedModel(code: 'A001036', breed: '[강아지] 보르조이'),
    MyBreedModel(code: 'A001037', breed: '[강아지] 보스턴 테리어'),
    MyBreedModel(code: 'A001038', breed: '[강아지] 복서'),
    MyBreedModel(code: 'A001039', breed: '[강아지] 볼로네즈'),
    MyBreedModel(code: 'A001040', breed: '[강아지] 부비에 데 플랑드르'),
    MyBreedModel(code: 'A001041', breed: '[강아지] 불도그'),
    MyBreedModel(code: 'A001042', breed: '[강아지] 불마스티프'),
    MyBreedModel(code: 'A001043', breed: '[강아지] 불테리어'),
    MyBreedModel(code: 'A001044', breed: '[강아지] 브리아드'),
    MyBreedModel(code: 'A001045', breed: '[강아지] 브리타니'),
    MyBreedModel(code: 'A001046', breed: '[강아지] 블랙 러시안 테리어'),
    MyBreedModel(code: 'A001047', breed: '[강아지] 블랙 앤드 탄 쿤하운드'),
    MyBreedModel(code: 'A001048', breed: '[강아지] 블러드하운드'),
    MyBreedModel(code: 'A001049', breed: '[강아지] 비글'),
    MyBreedModel(code: 'A001050', breed: '[강아지] 비숑 프리제'),
    MyBreedModel(code: 'A001051', breed: '[강아지] 비어디드 콜리'),
    MyBreedModel(code: 'A001052', breed: '[강아지] 비즐라'),
    MyBreedModel(code: 'A001053', breed: '[강아지] 사모예드'),
    MyBreedModel(code: 'A001054', breed: '[강아지] 살루키'),
    MyBreedModel(code: 'A001055', breed: '[강아지] 고든 세터'),
    MyBreedModel(code: 'A001056', breed: '[강아지] 골든 리트리버'),
    MyBreedModel(code: 'A001057', breed: '[강아지] 그레이트 데인'),
    MyBreedModel(code: 'A001058', breed: '[강아지] 그레이트 스위스 마운틴 도그'),
    MyBreedModel(code: 'A001059', breed: '[강아지] 그레이트 피레니즈'),
    MyBreedModel(code: 'A001060', breed: '[강아지] 그레이하운드'),
    MyBreedModel(code: 'A001061', breed: '[강아지] 글렌 오브 이말 테리어'),
    MyBreedModel(code: 'A001062', breed: '[강아지] 네오폴리탄 마스티프'),
    MyBreedModel(code: 'A001063', breed: '[강아지] 노르웨이 부훈트'),
    MyBreedModel(code: 'A001064', breed: '[강아지] 노르웨이 엘크하운드'),
    MyBreedModel(code: 'A001065', breed: '[강아지] 노리치 테리어'),
    MyBreedModel(code: 'A001066', breed: '[강아지] 노바 스코샤 덕 톨링 리트리버'),
    MyBreedModel(code: 'A001067', breed: '[강아지] 노퍽 테리어'),
    MyBreedModel(code: 'A001068', breed: '[강아지] 뉴펀들랜드'),
    MyBreedModel(code: 'A001069', breed: '[강아지] 닥스훈트'),
    MyBreedModel(code: 'A001070', breed: '[강아지] 달마시안'),
    MyBreedModel(code: 'A001071', breed: '[강아지] 댄디 딘몬트 테리어'),
    MyBreedModel(code: 'A001072', breed: '[강아지] 도고 카나리오'),
    MyBreedModel(code: 'A001073', breed: '[강아지] 도그 드 보르도'),
    MyBreedModel(code: 'A001074', breed: '[강아지] 도베르만 핀셔'),
    MyBreedModel(code: 'A001075', breed: '[강아지] 라사 압소'),
    MyBreedModel(code: 'A001076', breed: '[강아지] 라포니안 허더'),
    MyBreedModel(code: 'A001077', breed: '[강아지] 래브라도 리트리버'),
    MyBreedModel(code: 'A001078', breed: '[강아지] 레이크랜드 테리어'),
    MyBreedModel(code: 'A001079', breed: '[강아지] 로디지아 리지백'),
    MyBreedModel(code: 'A001080', breed: '[강아지] 로첸(로우첸)'),
    MyBreedModel(code: 'A001081', breed: '[강아지] 로트와일러'),
    MyBreedModel(code: 'A001082', breed: '[강아지] 마스티프'),
    MyBreedModel(code: 'A001083', breed: '[강아지] 맨체스터 테리어'),
    MyBreedModel(code: 'A001084', breed: '[강아지] 말티즈'),
    MyBreedModel(code: 'A001085', breed: '[강아지] 아이리시 워터 스패니얼'),
    MyBreedModel(code: 'A001086', breed: '[강아지] 아이리시 테리어'),
    MyBreedModel(code: 'A001087', breed: '[강아지] 아키타'),
    MyBreedModel(code: 'A001088', breed: '[강아지] 아펜핀셔'),
    MyBreedModel(code: 'A001089', breed: '[강아지] 아프간 하운드'),
    MyBreedModel(code: 'A001090', breed: '[강아지] 알래스칸 맬러뮤트'),
    MyBreedModel(code: 'A001091', breed: '[강아지] 에스트렐라 마운틴 독'),
    MyBreedModel(code: 'A001092', breed: '[강아지] 에어데일 테리어'),
    MyBreedModel(code: 'A001093', breed: '[강아지] 오스트레일리언 실키 테리어'),
    MyBreedModel(code: 'A001094', breed: '[강아지] 오스트레일리언 켈피'),
    MyBreedModel(code: 'A001095', breed: '[강아지] 오스트레일리언 셰퍼드'),
    MyBreedModel(code: 'A001096', breed: '[강아지] 오터하운드'),
    MyBreedModel(code: 'A001097', breed: '[강아지] 올드 잉글리시 시프도그'),
    MyBreedModel(code: 'A001098', breed: '[강아지] 와이마라너'),
    MyBreedModel(code: 'A001099', breed: '[강아지] 와이어 폭스 테리어'),
    MyBreedModel(code: 'A001100', breed: '[강아지] 와이어헤어드 포인팅 그리펀'),
    MyBreedModel(code: 'A001101', breed: '[강아지] 요크셔 테리어'),
    MyBreedModel(code: 'A001102', breed: '[강아지] 웨스트 하이랜드 화이트 테리어'),
    MyBreedModel(code: 'A001103', breed: '[강아지] 웰시 스프링어 스패니얼'),
    MyBreedModel(code: 'A001104', breed: '[강아지] 웰시 테리어'),
    MyBreedModel(code: 'A001105', breed: '[강아지] 이비전 하운드'),
    MyBreedModel(code: 'A001106', breed: '[강아지] 이탈리안 그레이하운드'),
    MyBreedModel(code: 'A001107', breed: '[강아지] 잉글리시 세터'),
    MyBreedModel(code: 'A001108', breed: '[강아지] 잉글리시 스프링어 스패니얼'),
    MyBreedModel(code: 'A001109', breed: '[강아지] 잉글리시 코커 스패니얼'),
    MyBreedModel(code: 'A001110', breed: '[강아지] 잉글리시 토이 스패니얼'),
    MyBreedModel(code: 'A001111', breed: '[강아지] 잉글리시 폭스하운드'),
    MyBreedModel(code: 'A001112', breed: '[강아지] 자이언트 슈나우저'),
    MyBreedModel(code: 'A001113', breed: '[강아지] 재패니즈 친'),
    MyBreedModel(code: 'A001114', breed: '[강아지] 저먼 셰퍼드 도그'),
    MyBreedModel(code: 'A001115', breed: '[강아지] 저먼 쇼트헤어드 포인터'),
    MyBreedModel(code: 'A001116', breed: '[강아지] 저먼 와이어헤어드 포인터'),
    MyBreedModel(code: 'A001117', breed: '[강아지] 저먼 핀셔'),
    MyBreedModel(code: 'A001118', breed: '[강아지] 저먼 헌팅 테리어'),
    MyBreedModel(code: 'A001119', breed: '[강아지] 차우차우'),
    MyBreedModel(code: 'A001120', breed: '[강아지] 차이니스 샤페이'),
    MyBreedModel(code: 'A001121', breed: '[강아지] 차이니스 크레스티드'),
    MyBreedModel(code: 'A001122', breed: '[강아지] 치와와'),
    MyBreedModel(code: 'A001123', breed: '[강아지] 카디건 웰시 코기'),
    MyBreedModel(code: 'A001124', breed: '[강아지] 카발리에 킹 찰스 스패니얼'),
    MyBreedModel(code: 'A001125', breed: '[강아지] 컬리 코티드 리트리버'),
    MyBreedModel(code: 'A001126', breed: '[강아지] 케리 블루 테리어'),
    MyBreedModel(code: 'A001127', breed: '[강아지] 케언 테리어'),
    MyBreedModel(code: 'A001128', breed: '[강아지] 케이넌 도그'),
    MyBreedModel(code: 'A001129', breed: '[강아지] 케이스혼트'),
    MyBreedModel(code: 'A001130', breed: '[강아지] 코몬도르'),
    MyBreedModel(code: 'A001131', breed: '[강아지] 코커 스패니얼'),
    MyBreedModel(code: 'A001132', breed: '[강아지] 코튼 드 튈레아르'),
    MyBreedModel(code: 'A001133', breed: '[강아지] 콜리'),
    MyBreedModel(code: 'A001134', breed: '[강아지] 쿠바스'),
    MyBreedModel(code: 'A001135', breed: '[강아지] 클럼버 스패니얼'),
    MyBreedModel(code: 'A001136', breed: '[강아지] 토이 폭스 테리어'),
    MyBreedModel(code: 'A001137', breed: '[강아지] 티베탄 마스티프'),
    MyBreedModel(code: 'A001138', breed: '[강아지] 티베탄 스패니얼'),
    MyBreedModel(code: 'A001139', breed: '[강아지] 티베탄 테리어'),
    MyBreedModel(code: 'A001140', breed: '[강아지] 파라오 하운드'),
    MyBreedModel(code: 'A001141', breed: '[강아지] 파슨 러셀 테리어'),
    MyBreedModel(code: 'A001142', breed: '[강아지] 파피용'),
    MyBreedModel(code: 'A001143', breed: '[강아지] 퍼그'),
    MyBreedModel(code: 'A001144', breed: '[강아지] 페키니즈'),
    MyBreedModel(code: 'A001145', breed: '[강아지] 펨브로크 웰시 코기'),
    MyBreedModel(code: 'A001146', breed: '[강아지] 포르투갈 워터 도그'),
    MyBreedModel(code: 'A001147', breed: '[강아지] 서식스 스패니얼'),
    MyBreedModel(code: 'A001148', breed: '[강아지] 세인트 버나드'),
    MyBreedModel(code: 'A001149', breed: '[강아지] 셔틀랜드 쉽독'),
    MyBreedModel(code: 'A001150', breed: '[강아지] 소프트 코티드 휘튼 테리어'),
    MyBreedModel(code: 'A001151', breed: '[강아지] 스무드 폭스 테리어'),
    MyBreedModel(code: 'A001152', breed: '[강아지] 스위디시 발훈드'),
    MyBreedModel(code: 'A001153', breed: '[강아지] 스카이 테리어'),
    MyBreedModel(code: 'A001154', breed: '[강아지] 스코티시 디어하운드'),
    MyBreedModel(code: 'A001155', breed: '[강아지] 스코티시 테리어'),
    MyBreedModel(code: 'A001156', breed: '[강아지] 스키퍼키'),
    MyBreedModel(code: 'A001157', breed: '[강아지] 스태퍼드셔 불테리어'),
    MyBreedModel(code: 'A001158', breed: '[강아지] 스탠더드 슈나우저'),
    MyBreedModel(code: 'A001159', breed: '[강아지] 스페니시 마스티프'),
    MyBreedModel(code: 'A001160', breed: '[강아지] 스피노네 이탈리아노'),
    MyBreedModel(code: 'A001161', breed: '[강아지] 시바이누'),
    MyBreedModel(code: 'A001162', breed: '[강아지] 시베리언 허스키'),
    MyBreedModel(code: 'A001163', breed: '[강아지] 시추'),
    MyBreedModel(code: 'A001164', breed: '[강아지] 실리엄 테리어'),
    MyBreedModel(code: 'A001165', breed: '[강아지] 실키 테리어'),
    MyBreedModel(code: 'A001166', breed: '[강아지] 아나톨리안 셰퍼드 도그'),
    MyBreedModel(code: 'A001167', breed: '[강아지] 아메리칸 스태퍼드셔 테리어'),
    MyBreedModel(code: 'A001168', breed: '[강아지] 아메리칸 아키다'),
    MyBreedModel(code: 'A001169', breed: '[강아지] 아메리칸 에스키모 도그'),
    MyBreedModel(code: 'A001170', breed: '[강아지] 아메리칸 워터 스패니얼'),
    MyBreedModel(code: 'A001171', breed: '[강아지] 아메리칸 폭스하운드'),
    MyBreedModel(code: 'A001172', breed: '[강아지] 아이리시 레드 앤드 화이트 세터'),
    MyBreedModel(code: 'A001173', breed: '[강아지] 아이리시 세터'),
    MyBreedModel(code: 'A001174', breed: '[강아지] 아이리시 울프하운드'),
    // MyBreedModel(code: 'A002001', breed: '[고양이] 코리안숏헤어'),
    // MyBreedModel(code: 'A002002', breed: '[고양이] 러시안블루'),
    // MyBreedModel(code: 'A002003', breed: '[고양이] 샴'),
    // MyBreedModel(code: 'A002004', breed: '[고양이] 스코티시폴드'),
    // MyBreedModel(code: 'A002005', breed: '[고양이] 브리티시숏헤어'),
    // MyBreedModel(code: 'A002006', breed: '[고양이] 뱅갈'),
    // MyBreedModel(code: 'A002007', breed: '[고양이] 메인쿤'),
    // MyBreedModel(code: 'A002008', breed: '[고양이] 터키시앙고라'),
    // MyBreedModel(code: 'A002009', breed: '[고양이] 노르웨이숲'),
    // MyBreedModel(code: 'A002010', breed: '[고양이] 페르시안'),
    // MyBreedModel(code: 'A002011', breed: '[고양이] 아메리칸쇼트헤어'),
    // MyBreedModel(code: 'A002012', breed: '[고양이] 랙돌'),
    // MyBreedModel(code: 'A002013', breed: '[고양이] 버만'),
    // MyBreedModel(code: 'A002014', breed: '[고양이] 싱가푸라'),
    // MyBreedModel(code: 'A002015', breed: '[고양이] 소말리'),
    // MyBreedModel(code: 'A002016', breed: '[고양이] 스핑크스'),
    // MyBreedModel(code: 'A002017', breed: '[고양이] 아비시니안'),
    // MyBreedModel(code: 'A002018', breed: '[고양이] 히말라얀'),
    // MyBreedModel(code: 'A002019', breed: '[고양이] 셀커크렉스'),
    // MyBreedModel(code: 'A002020', breed: '[고양이] 오리엔탈숏헤어'),
  ];
  List<MyFeedModel> totalPetFeeds = [
    MyFeedModel(food_id:44, food_name: '오리젠 퍼피 340g'),
    MyFeedModel(food_id:45, food_name: '오리젠 퍼피 1kg'),
    MyFeedModel(food_id:46, food_name: '오리젠 퍼피 2kg'),
    MyFeedModel(food_id:47, food_name: '오리젠 퍼피 6kg'),
    MyFeedModel(food_id:48, food_name: '오리젠 퍼피 11.4kg'),
    MyFeedModel(food_id:49, food_name: '오리젠 스몰브리드 독 1.8kg'),
    MyFeedModel(food_id:50, food_name: '오리젠 스몰브리드 독 4.5kg'),
    MyFeedModel(food_id:51, food_name: '오리젠 시니어 독 340g'),
    MyFeedModel(food_id:52, food_name: '오리젠 시니어 독 1kg'),
    MyFeedModel(food_id:53, food_name: '오리젠 시니어 독 2kg'),
    MyFeedModel(food_id:54, food_name: '오리젠 시니어 독 6kg'),
    MyFeedModel(food_id:55, food_name: '오리젠 시니어 독 11.4kg'),
    MyFeedModel(food_id:56, food_name: '오리젠 툰드라 독 2kg'),
    MyFeedModel(food_id:57, food_name: '오리젠 툰드라 독 6kg'),
    MyFeedModel(food_id:58, food_name: '오리젠 툰드라 독 11.4kg'),
    MyFeedModel(food_id:59, food_name: '오리젠 퍼피 라지 6kg'),
    MyFeedModel(food_id:60, food_name: '오리젠 퍼피 라지 11.4kg'),
    MyFeedModel(food_id:61, food_name: '오리젠 오리지널 독 340g'),
    MyFeedModel(food_id:62, food_name: '오리젠 오리지널 독 1kg'),
    MyFeedModel(food_id:63, food_name: '오리젠 오리지널 독 2kg'),
    MyFeedModel(food_id:64, food_name: '오리젠 오리지널 독 6kg'),
    MyFeedModel(food_id:65, food_name: '오리젠 오리지널 독 11.4kg'),
    MyFeedModel(food_id:66, food_name: '오리젠 6피쉬 독 340g'),
    MyFeedModel(food_id:67, food_name: '오리젠 6피쉬 독 1kg'),
    MyFeedModel(food_id:68, food_name: '오리젠 6피쉬 독 2kg'),
    MyFeedModel(food_id:69, food_name: '오리젠 6피쉬 독 6kg'),
    MyFeedModel(food_id:70, food_name: '오리젠 6피쉬 독 11.4kg'),
    MyFeedModel(food_id:71, food_name: '오리젠 이저날 레드 독 2kg'),
    MyFeedModel(food_id:72, food_name: '오리젠 이저날 레드 독 6kg'),
    MyFeedModel(food_id:73, food_name: '오리젠 이저날 레드 독 11.4kg'),
    MyFeedModel(food_id:74, food_name: '오리젠 피트 앤 트림 독 1kg'),
    MyFeedModel(food_id:75, food_name: '오리젠 피트 앤 트림 독 2kg'),
    MyFeedModel(food_id:76, food_name: '오리젠 피트 앤 트림 독 6kg'),
    MyFeedModel(food_id:77, food_name: '오리젠 피트 앤 트림 독 11.4kg'),
    MyFeedModel(food_id:78, food_name: '아미오 오리진 슬림업 오리 1.4kg'),
    MyFeedModel(food_id:79, food_name: '아미오 오리진 슬림업 오리 5kg'),
    MyFeedModel(food_id:80, food_name: '지위픽 독 식품 닭고기 454g'),
    MyFeedModel(food_id:81, food_name: '지위픽 독 식품 닭고기 1kg'),
    MyFeedModel(food_id:82, food_name: '지위픽 독 식품 닭고기 2.5kg'),
    MyFeedModel(food_id:83, food_name: '지위픽 독 식품 닭고기 4kg'),
    MyFeedModel(food_id:84, food_name: '지위픽 독 캔식품 양고기 170g'),
    MyFeedModel(food_id:85, food_name: '지위픽 독 캔식품 양고기 390g'),
    MyFeedModel(food_id:86, food_name: '지위픽 독 캔식품 소고기'),
    MyFeedModel(food_id:87, food_name: '지위픽 독 캔식품 닭고기'),
    MyFeedModel(food_id:88, food_name: '지위픽 독 식품 트라이프와 양고기 454g'),
    MyFeedModel(food_id:89, food_name: '지위픽 독 식품 트라이프와 양고기 1kg'),
    MyFeedModel(food_id:90, food_name: '지위픽 독 식품 트라이프와 양고기 2.5kg'),
    MyFeedModel(food_id:91, food_name: '지위픽 독 캔식품 사슴고기'),
    MyFeedModel(food_id:92, food_name: '지위픽 독 식품 고등어와 양고기 454g'),
    MyFeedModel(food_id:93, food_name: '지위픽 독 식품 고등어와 양고기 1kg'),
    MyFeedModel(food_id:94, food_name: '지위픽 독 식품 고등어와 양고기 2.5kg'),
    MyFeedModel(food_id:95, food_name: '지위픽 독 식품 고등어와 양고기 4kg'),
    MyFeedModel(food_id:96, food_name: '지위픽 독 식품 사슴고기 454g'),
    MyFeedModel(food_id:97, food_name: '지위픽 독 식품 사슴고기 1kg'),
    MyFeedModel(food_id:98, food_name: '지위픽 독 식품 사슴고기 2.5kg'),
    MyFeedModel(food_id:99, food_name: '지위픽 독 에어드라이 양고기 454g'),
    MyFeedModel(food_id:100, food_name: '지위픽 독 에어드라이 양고기 1kg'),
    MyFeedModel(food_id:101, food_name: '지위픽 독 에어드라이 양고기 2.5kg'),
    MyFeedModel(food_id:102, food_name: '지위픽 독 에어드라이 양고기 4kg'),
    MyFeedModel(food_id:103, food_name: '지위픽 독 식품 소고기 454g'),
    MyFeedModel(food_id:104, food_name: '지위픽 독 식품 소고기 1kg'),
    MyFeedModel(food_id:105, food_name: '지위픽 독 식품 소고기 2.5kg'),
    MyFeedModel(food_id:106, food_name: '지위픽 독 식품 소고기 4kg'),
    MyFeedModel(food_id:107, food_name: '지위픽 독 캔식품 트라이프와 양고기'),
    MyFeedModel(food_id:108, food_name: '지위픽 독 캔식품 고등어와 양고기'),
    MyFeedModel(food_id:109, food_name: '지위픽 독 프로비넌스 오타고 벨리 140g'),
    MyFeedModel(food_id:110, food_name: '지위픽 독 프로비넌스 오타고 벨리 900g'),
    MyFeedModel(food_id:111, food_name: '지위픽 독 프로비넌스 오타고 벨리 1.8kg'),
    MyFeedModel(food_id:112, food_name: '지위픽 프로비넌스 이스트 케이프 독 캔 140g'),
    MyFeedModel(food_id:113, food_name: '지위픽 프로비넌스 이스트 케이프 독 캔 900g'),
    MyFeedModel(food_id:114, food_name: '지위픽 프로비넌스 이스트 케이프 독 캔 1.8kg'),
    MyFeedModel(food_id:115, food_name: '지위픽 프로비넌스 하우라키 케이프 독 캔'),
    MyFeedModel(food_id:116, food_name: '지위픽 프로비넌스 오타고 밸리 독 캔 170g'),
    MyFeedModel(food_id:117, food_name: '지위픽 독 식품 프로비넌스 하우라키 플레인즈 140g'),
    MyFeedModel(food_id:118, food_name: '지위픽 독 식품 프로비넌스 하우라키 플레인즈 900g'),
    MyFeedModel(food_id:119, food_name: '지위픽 독 식품 프로비넌스 하우라키 플레인즈 1.8kg'),
    MyFeedModel(food_id:120, food_name: '파미나 Vet Life Dog 카디약 2kg'),
    MyFeedModel(food_id:121, food_name: '파미나 Vet Life Dog 조인트 2kg'),
    MyFeedModel(food_id:122, food_name: '파미나 Vet Life Dog 오베시티 2kg'),
    MyFeedModel(food_id:123, food_name: '파미나 Vet Life Dog 가스트로인테스티널 2kg'),
    MyFeedModel(food_id:124, food_name: '파미나 Vet Life Dog 울트라하이포 2kg'),
    MyFeedModel(food_id:125, food_name: '파미나 Vet Life Dog 울트라하이포 12kg'),
    MyFeedModel(food_id:126, food_name: '파미나 Vet Life Dog 레날 2kg'),
    MyFeedModel(food_id:127, food_name: '파미나 Vet Life Dog 헤파틱 2kg'),
    MyFeedModel(food_id:128, food_name: '파미나 Vet Life Dog 옥살레이트 2kg'),
    MyFeedModel(food_id:129, food_name: '파미나 Vet Life Dog 스트루바이트 매니지먼트 2kg'),
    MyFeedModel(food_id:130, food_name: '파미나 Vet Life Dog 하이포엘러제닉 생선&감자 2kg'),
    MyFeedModel(food_id:131, food_name: '파미나 Vet Life Dog 하이포엘러제닉 달걀&쌀 2kg'),
    MyFeedModel(food_id:132, food_name: '파미나 Vet Life Dog Derma Management 피쉬 습식캔'),
    MyFeedModel(food_id:133, food_name: '파미나 N&D Dog 그레인프리 청어&오렌지 미니 800g'),
    MyFeedModel(food_id:134, food_name: '파미나 N&D Dog 그레인프리 청어&오렌지 1.5kg'),
    MyFeedModel(food_id:135, food_name: '파미나 N&D Dog 그레인프리 청어&오렌지 2.5kg'),
    MyFeedModel(food_id:136, food_name: '파미나 N&D Dog 그레인프리 청어&오렌지 5kg'),
    MyFeedModel(food_id:137, food_name: '파미나 N&D Dog 그레인프리 청어&오렌지 7kg'),
    MyFeedModel(food_id:138, food_name: '파미나 Vet Life Dog Derma Management 오리 습식캔'),
    MyFeedModel(food_id:139, food_name: '파미나 N&D Dog 그레인프리 펌프킨 멧돼지&사과 미디움 20kg'),
    MyFeedModel(food_id:140, food_name: '파미나 N&D Dog 그레인프리 펌프킨 닭고기&석류 미니 1.5kg'),
    MyFeedModel(food_id:141, food_name: '파미나 N&D Dog 그레인프리 닭고기&석류 5kg'),
    MyFeedModel(food_id:142, food_name: '파미나 N&D Dog 로우그레인(귀리) 닭고기&석류 20kg'),
    MyFeedModel(food_id:143, food_name: '파미나 N&D Dog 로우그레인(귀리) 닭고기&석류 미니 2.5kg'),
    MyFeedModel(food_id:144, food_name: '파미나 N&D Dog 그레인프리 펌프킨 멧돼지&사과 미니 800g'),
    MyFeedModel(food_id:145, food_name: '파미나 N&D Dog 그레인프리 펌프킨 멧돼지&사과 미니 2.5kg'),
    MyFeedModel(food_id:146, food_name: '파미나 N&D Dog 그레인프리 펌프킨 멧돼지&사과 미니 7kg'),
    MyFeedModel(food_id:147, food_name: '파미나 N&D Dog 그레인프리 펌프킨 멧돼지&사과 미니 12kg'),
    MyFeedModel(food_id:148, food_name: '파미나 N&D Dog 그레인프리 펌프킨 대구&오렌지 미니 800g'),
    MyFeedModel(food_id:149, food_name: '파미나 N&D Dog 그레인프리 펌프킨 대구&오렌지 미니 2.5g'),
    MyFeedModel(food_id:150, food_name: '파미나 N&D Dog 그레인프리 펌프킨 대구&오렌지 미니 7kg'),
    MyFeedModel(food_id:151, food_name: '파미나 N&D Dog 그레인프리 펌프킨 대구&오렌지 미디움 12kg'),
    MyFeedModel(food_id:152, food_name: '파미나 N&D Dog 그레인프리 펌프킨 대구&오렌지 미디움 20kg'),
  ];

  final List<String> foodRemainGradeCode = ['A', 'B', 'C']; // 서버에 보낼 사료 남은 양 (A:79, B:30, C:10)
  List<String> leftoverFeed = ['50% 이상', '11~50%', '10% 이하']; // 화면에 표시할 사료 남은 양

  TextEditingController petNameInputController = TextEditingController();
  TextEditingController petTypeInputController = TextEditingController();
  TextEditingController petFeedInputController = TextEditingController();
  TextEditingController petBirthInputController = TextEditingController();

  ScrollController petTypeScrollController = ScrollController();
  ScrollController petFeedScrollController = ScrollController();

  int fnGetPetTypesIndexByCode(String code) {
    int index = totalPetTypes.indexWhere((model) => model.code == code);

    return index != -1 ? index : 0;
  }

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

  String fnGetCodeFromBreed(String selectedBreed) {
    final match = totalPetTypes.firstWhere(
      (e) => e.breed == selectedBreed,
      orElse: () => MyBreedModel(code: '', breed: ''),
    );
    // debugPrint(match.code.isEmpty ? '' : match.code);
    return match.code.isEmpty ? '' : match.code;
  }

  String fnGetBreedFromCode(String code) {
    final match = totalPetTypes.firstWhere(
      (e) => e.code == code,
      orElse: () => MyBreedModel(code: '', breed: ''),
    );
    return match.breed.isEmpty ? '' : match.breed;
  }

  void fnSelectPetTypeItems(String selected) {
    petTypeInputController.text = selected;

    myRef.read(requestNewDogProvider.notifier).setDivision2Code(fnGetCodeFromBreed(selected));
    myRef.read(requestUpdateDogProvider.notifier).setDivision2Code(fnGetCodeFromBreed(selected));

    myRef.read(myPetAddTypeDropdownProvider.notifier).set(false);
  }

  void fnGetFilteredPetFeedItems(String input) {
    myRef.read(myPetAddFeedFilterProvider.notifier).set(
      totalPetFeeds
        .where((item) => item.food_name.contains(input))
        .map((item) => item.food_name).toList()
    );

    myRef.read(myPetAddFeedDropdownProvider.notifier).set(true);
  }

  void fnGetAllPetFeedItems() {
    myRef.read(myPetAddFeedFilterProvider.notifier).set(
      List.from(totalPetFeeds.map((item) => item.food_name))
    );

    myRef.read(myPetAddFeedDropdownProvider.notifier).set(true);
  }

  int fnGetIdFromFeed(String selectedFeed) {
    final match = totalPetFeeds.firstWhere(
      (e) => e.food_name == selectedFeed,
      orElse: () => MyFeedModel(food_id: -1, food_name: ''),
    );
    // debugPrint(match.food_id.toString());
    return match.food_id;
  }
  // 참고 : 사료 데이터 칼럼 명칭이 food_id, food_name으로 되어있음 
  // 참고 : 반려동물 추가, 수정할 때는 feed_id임
  String fnGetFeedFromId(int foodId) {
    final match = totalPetFeeds.firstWhere(
      (e) => e.food_id == foodId,
      orElse: () => MyFeedModel(food_id: -1, food_name: ''),
    );

    return match.food_name;
  }

  void fnSelectPetFeedItems(String selected) {
    petFeedInputController.text = selected;

    myRef.read(requestNewDogProvider.notifier).setFeedId(fnGetIdFromFeed(selected));
    myRef.read(requestUpdateDogProvider.notifier).setFeedId(fnGetIdFromFeed(selected));

    myRef.read(myPetAddFeedDropdownProvider.notifier).set(false);
  }

  bool fnCheckTimeBeforeConvert(String meridiem, String hour, String minute) {
    bool result = false;

    if(meridiem.isEmpty) {
      showAlertDialog(
        context: myContext, 
        middleText: '오전/오후를 선택해주세요.',
      );
      return result;
    }
    if(hour.isEmpty) {
      showAlertDialog(
        context: myContext, 
        middleText: '시간을 입력해주세요.',
      );
      return result;
    }
    if(minute.isEmpty) {
      showAlertDialog(
        context: myContext, 
        middleText: '분을 입력해주세요.',
      );
      return result;
    }

    int h = int.parse(hour);
    int m = int.parse(minute);

    if(h < 1 || h > 12) {
      showAlertDialog(
        context: myContext, 
        middleText: '시간은 1 이상, 12 이하로 입력해주세요.',
      );
      return result;
    }
    if(m > 59) {
      showAlertDialog(
        context: myContext, 
        middleText: '분은 60 미만으로 입력해주세요.',
      );
      return result;
    }
    
    result = true;
    return result;
  }

  // 12시간제를 24시간제로 변경 (화면에 입력한 급여 시간을 서버에 보낼 수 있는 형식으로 변경)
  String fnConvertTime12To24(String meridiem, String hour, String minute) {
    int h = int.parse(hour);
    int m = int.parse(minute);

    if(h > 12) return '';
    if(m > 59) return '';

    if(meridiem == 'AM') {
      if(h == 12) h = 0;
    }
    if(meridiem == 'PM') {
      if(h == 12) h = 12;
      if(h < 12) h += 12;
    }
    
    return '${h < 10 ? '0' : ''}$h:${m < 10 ? '0' : ''}$m';
  }
  // 24시간제를 12시간제로 변경 (서버에서 받아온 값을 화면에 정해진 형식으로 표시 - 오전/오후)
  String fnConvertTime24To12(String formattedTime) {
    List<String> time24List = formattedTime.split(":");
    String meridiem = '';
    int h = int.parse(time24List[0]);
    int m = int.parse(time24List[1]);

    if(h < 12) {
      meridiem = '오전';

      if(h == 0) h = 12;
    } else {
      meridiem = '오후';

      if(h > 12) h -= 12;
    }

    return '$meridiem ${h < 10 ? '0' : ''}$h:${m < 10 ? '0' : ''}$m';
  }

  // ########################################
  // 반려동물 추가
  // ########################################

  // 반려동물 추가 전 유효성 검사
  bool fnCheckPetName(String petName) {
    bool result = false;

    if(petName.isEmpty) { 
      myRef.read(myPetAddNameInputStatusCodeProvider.notifier)
           .set(ProjectConstant.INPUT_ERR_EMPTY);
      result = false; 
    } else if(petName.length > 5) {
      myRef.read(myPetAddNameInputStatusCodeProvider.notifier)
           .set(ProjectConstant.INPUT_ERR_LENGTH);
      result = false; 
    } else {
      myRef.read(myPetAddNameInputStatusCodeProvider.notifier)
           .set(ProjectConstant.INPUT_SUCCESS);
      result = true; 
    }

    return result;
  }

  bool fnCheckPetSize(String petSize) {
    bool result = false;

    if(petSize.isNotEmpty) result = true;

    return result;
  }

  bool fnCheckPetType(String code) {
    bool result = false;

    if(code.isNotEmpty) result = true;

    return result;
  }

  bool fnCheckPetGender(String petGender) {
    bool result = false;

    if(petGender == femaleCode || petGender == maleCode) result = true;

    return result;
  }

  bool fnCheckPetNeuter(bool? petNeuter) {
    bool result = false;

    if(petNeuter != null) result = true;

    return result;
  }

  bool fnCheckPetFeed(int feedId) {
    bool result = false;

    if(feedId != -1) result = true;

    return result;
  }

  bool fnCheckPetFeedTime(List<String> feedTime) {
    bool result = false;

    if(feedTime.isNotEmpty) result = true;

    return result;
  }

  bool fnCheckPetFeedRemainGrade(String feedRemainGrade) {
    bool result = false;

    if(feedRemainGrade.isNotEmpty) result = true;

    return result;
  }

  bool fnCheckPetBirth(String birth) {
    bool result = false;

    if(birth.isEmpty) {
      myRef.read(myPetAddBirthInputStatusCodeProvider.notifier)
           .set(ProjectConstant.INPUT_ERR_EMPTY);
      return result;
    } else if(birth.length != 10) {
      myRef.read(myPetAddBirthInputStatusCodeProvider.notifier)
           .set(ProjectConstant.INPUT_ERR_LENGTH);
      return result;
    } 
    
    if(birth.length == 10) {
      bool formatResult = fnValidateBirthFormat(birth);
      if(!formatResult) {
        myRef.read(myPetAddBirthInputStatusCodeProvider.notifier)
             .set(ProjectConstant.INPUT_ERR_FORMAT); 
        return result;
      } else {
        myRef.read(myPetAddBirthInputStatusCodeProvider.notifier)
             .set(ProjectConstant.INPUT_SUCCESS);

        result = true;
      }
    }

    return result;
  }

  Future<void> fnMyPetAddExec() async {
    final String petName = myRef.read(requestNewDogProvider.notifier).getPetName();
    final String petSize = myRef.read(requestNewDogProvider.notifier).getPetSize();
    final String petType = myRef.read(requestNewDogProvider.notifier).getDivision2Code();
    final String petGender = myRef.read(requestNewDogProvider.notifier).getPetGender();
    bool? neuterYn = myRef.read(requestNewDogProvider.notifier).getNeuterYn();
    final int feedId = myRef.read(requestNewDogProvider.notifier).getFeedId();
    final List<String> feedTime = myRef.read(requestNewDogProvider.notifier).getFeedTime();
    final String petBirth = myRef.read(requestNewDogProvider.notifier).getPetBirth();
    final String foodRemainGrade = myRef.read(requestNewDogProvider.notifier).getFoodRemainGrade();

    // debugPrint(petName);
    // debugPrint(petSize);
    // debugPrint(petType);
    // debugPrint(petGender);
    // debugPrint(neuterYn.toString());
    // debugPrint(feedId.toString());
    // debugPrint(feedTime.toString());
    // debugPrint(petBirth);
    // debugPrint(foodRemainGrade);

    if(!fnCheckPetName(petName)) {
      if(petName.isEmpty) {
        showAlertDialog(
          context: myContext, 
          middleText: Sentence.PET_NAME_ERR_EMPTY,
        );
        return;
      } else if(petName.length > 5) {
        showAlertDialog(
          context: myContext, 
          middleText: Sentence.PET_NAME_ERR_LENGTH,
        );
        return;
      }
    }

    if(!fnCheckPetSize(petSize)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_SIZE_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetType(petType)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_TYPE_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetGender(petGender)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_GENDER_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetNeuter(neuterYn)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_NEUTER_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetFeed(feedId)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_FEED_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetFeedTime(feedTime)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_FEED_TIME_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetFeedRemainGrade(foodRemainGrade)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_FEED_AMOUNT_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetBirth(petBirth)) {
      if(petBirth.isEmpty) {
        showAlertDialog(
          context: myContext, 
          middleText: Sentence.PET_BIRTH_ERR_EMPTY,
        );
      } else if(petBirth.length != 10) {
        showAlertDialog(
          context: myContext, 
          middleText: Sentence.PET_BIRTH_ERR_LENGTH,
        );
      } else if(petBirth.length == 10) {
        if(!fnValidateBirthFormat(petBirth)) {
          showAlertDialog(
            context: myContext, 
            middleText: Sentence.PET_BIRTH_ERR_FORMAT,
          );
        }
      }
      return;
    }

    // 로딩 시작
    showLoadingDialog(context: myContext);

    try {
      final response = await myRef.read(petRepositoryProvider).requestNewDogRepository(
        RequestNewDogModel(
          pet_name: petName, 
          pet_size: petSize, 
          division2_code: petType, 
          pet_gender: petGender, 
          neuter_yn: neuterYn, 
          feed_id: feedId, 
          feed_time: feedTime, 
          pet_birth: petBirth,
          food_remain_grade: foodRemainGrade,
        ),
      );

      if(response.response_code == 200) {
        // ResponseUsersModel responseUsersModel = ResponseUsersModel.fromJson(response.data);

        // await ControllerUtils.fnGetUserMypageExec(myRef);

        // debugPrint(response.data.toString());
        
        if(!myContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(myContext);
        // 성공 알림창
        showAlertDialog(
          context: myContext, 
          middleText: "반려동물 추가가 완료되었습니다.",
          barrierDismissible: false,
          onConfirm: () async {
            await ControllerUtils.fnGetDogsExec(myRef, myContext);
            // 상태 초기화
            fnInvalidateMyPetAddState();
            // 페이지 이동
            if(!myContext.mounted) return;
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
          middleText: "반려동물 추가에 실패했습니다."
        );
        return;
      }
    } on DioException catch(e) {
      // debugPrint("========== Request NewDog Dio Exception ==========");
      // debugPrint(e.toString());

      // 로딩 끝
      if(!myContext.mounted) return;
      hideLoadingDialog(myContext);

      // 에러 알림창
      showAlertDialog(
        context: myContext, 
        middleText: '${Sentence.SERVER_ERR}\n$e',
      );
    }
  }


  // 반려동물 수정하기 화면 초기화
  void fnInitMyPetUpdateState(ResponseDogsDetailModel responseDogsDetailModel) {
    myRef.read(myPetAddTypeFilterProvider.notifier).set([]);
    myRef.read(myPetAddTypeDropdownProvider.notifier).set(false);
    myRef.read(myPetAddFeedFilterProvider.notifier).set([]);
    myRef.read(myPetAddFeedDropdownProvider.notifier).set(false);
    myRef.read(myPetAddSizeButtonProvider.notifier).set(responseDogsDetailModel.pet_size);
    myRef.read(myPetAddGenderButtonProvider.notifier).set(responseDogsDetailModel.pet_gender.toUpperCase());
    myRef.read(myPetAddNeuterButtonProvider.notifier).set(responseDogsDetailModel.neuter_yn ? 'Y' : 'N');
    myRef.read(myPetAddFeedAmountButtonProvider.notifier).set(responseDogsDetailModel.foodGrade ?? ""); // v2 오류 조치
    myRef.read(myPetAddNameInputStatusCodeProvider.notifier).set(ProjectConstant.INPUT_SUCCESS);
    myRef.read(myPetAddBirthInputStatusCodeProvider.notifier).set(ProjectConstant.INPUT_SUCCESS);
    myRef.read(requestNewDogProvider.notifier).set(
      RequestNewDogModel(
        pet_name: '',
        pet_size: '',
        division2_code: '',
        pet_gender: '',
        neuter_yn: null,
        feed_id: -1,
        feed_time: [],
        pet_birth: '',
        food_remain_grade: '',
      ),
    );
    myRef.read(requestUpdateDogProvider.notifier).set(
      RequestUpdateDogModel(
        pet_name: responseDogsDetailModel.pet_name,
        pet_size: responseDogsDetailModel.pet_size,
        division2_code: responseDogsDetailModel.division2_code,
        pet_gender: responseDogsDetailModel.pet_gender,
        neuter_yn: responseDogsDetailModel.neuter_yn,
        feed_id: responseDogsDetailModel.feed ?? -1,
        feed_time: responseDogsDetailModel.feed_time ?? [],
        pet_birth: responseDogsDetailModel.pet_birth.substring(0, 10),
        food_remain_grade: responseDogsDetailModel.foodGrade ?? "",
      ),
    );
    myRef.read(myPetAddFeedTimeListProvider.notifier).set(responseDogsDetailModel.feed_time ?? []);
    myRef.read(myPetAddFeedTimeDeleteListProvider.notifier).set([]);
    myRef.read(myPetAddFeedTimeMeridiemButtonProvider.notifier).set("");
    myRef.read(myPetAddFeedTimeSelectModeProvider.notifier).set("");

    petNameInputController.text = responseDogsDetailModel.pet_name;
    petTypeInputController.text = fnGetBreedFromCode(responseDogsDetailModel.division2_code);
    petFeedInputController.text = fnGetFeedFromId(responseDogsDetailModel.feed ?? -1);
    petBirthInputController.text = responseDogsDetailModel.pet_birth.substring(0, 10);

    myRef.read(myPetUpdateButtonProvider.notifier).activate(
      myRef.read(requestUpdateDogProvider.notifier).get(),
    );
  }

  // ########################################
  // 반려동물 수정
  // 설명 : Model, Dio 요청 Repository은 Update용으로 만듦, 반려동물 추가와 Provider를 같이 사용
  // ########################################
  Future<void> fnMyPetUpdateExec(int pet_id) async {
    final String petName = myRef.read(requestUpdateDogProvider.notifier).getPetName();
    final String petSize = myRef.read(requestUpdateDogProvider.notifier).getPetSize();
    final String petType = myRef.read(requestUpdateDogProvider.notifier).getDivision2Code();
    final String petGender = myRef.read(requestUpdateDogProvider.notifier).getPetGender();
    bool? neuterYn = myRef.read(requestUpdateDogProvider.notifier).getNeuterYn();
    final int feedId = myRef.read(requestUpdateDogProvider.notifier).getFeedId();
    final List<String> feedTime = myRef.read(requestUpdateDogProvider.notifier).getFeedTime();
    final String petBirth = myRef.read(requestUpdateDogProvider.notifier).getPetBirth();
    final String foodRemainGrade = myRef.read(requestUpdateDogProvider.notifier).getFoodRemainGrade();

    // debugPrint(pet_id.toString());
    // debugPrint(petName);
    // debugPrint(petSize);
    // debugPrint(petType);
    // debugPrint(petGender);
    // debugPrint(neuterYn.toString());
    // debugPrint(feedId.toString());
    // debugPrint(feedTime.toString());
    // debugPrint(petBirth);
    // debugPrint(foodRemainGrade);

    if(!fnCheckPetName(petName)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_NAME_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetSize(petSize)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_SIZE_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetType(petType)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_TYPE_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetGender(petGender.toUpperCase())) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_GENDER_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetNeuter(neuterYn)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_NEUTER_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetFeed(feedId)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_FEED_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetFeedTime(feedTime)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_FEED_TIME_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetFeedRemainGrade(foodRemainGrade)) {
      showAlertDialog(
        context: myContext, 
        middleText: Sentence.PET_FEED_AMOUNT_ERR_EMPTY,
      );
      return;
    }

    if(!fnCheckPetBirth(petBirth)) {
      if(petBirth.isEmpty) {
        showAlertDialog(
          context: myContext, 
          middleText: Sentence.PET_BIRTH_ERR_EMPTY,
        );
      } else if(petBirth.length != 10) {
        showAlertDialog(
          context: myContext, 
          middleText: Sentence.PET_BIRTH_ERR_LENGTH,
        );
      } else if(petBirth.length == 10 && !fnValidateBirthFormat(petBirth)) {
        showAlertDialog(
          context: myContext, 
          middleText: Sentence.PET_BIRTH_ERR_FORMAT,
        );
      }
      return;
    }

    // 로딩 시작
    showLoadingDialog(context: myContext);

    try {
      final response = await myRef.read(petRepositoryProvider).requestUpdateDogRepository(
        pet_id,
        RequestUpdateDogModel(
          pet_name: petName, 
          pet_size: petSize, 
          division2_code: petType, 
          pet_gender: petGender, 
          neuter_yn: neuterYn, 
          feed_id: feedId, 
          feed_time: feedTime, 
          pet_birth: petBirth,
          food_remain_grade: foodRemainGrade,
        ),
      );

      if(response.response_code == 200) {
        // ResponseUsersModel responseUsersModel = ResponseUsersModel.fromJson(response.data);

        // await ControllerUtils.fnGetUserMypageExec(myRef);

        // debugPrint(response.data.toString());
        
        if(!myContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(myContext);
        // 성공 알림창
        showAlertDialog(
          context: myContext, 
          middleText: "반려동물 수정이 완료되었습니다.",
          barrierDismissible: false,
          onConfirm: () async {
            await ControllerUtils.fnGetDogsExec(myRef, myContext);
            // 상태 초기화
            fnInvalidateMyPetAddState();
            // 페이지 이동
            if(!myContext.mounted) return;
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
          middleText: "반려동물 수정에 실패했습니다."
        );
        return;
      }
    } on DioException catch(e) {
      // debugPrint("========== Request Update Dio Exception ==========");
      // debugPrint(e.toString());

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

  // ########################################
  // 반려동물 조회
  // ########################################
  // Future<void> fnGetDogsExec() async {
  //   try {
  //     // 로딩 시작
  //     showLoadingDialog(context: myContext);

  //     final response = await myRef.read(petRepositoryProvider).requestDogsRepository();

  //     if(response.response_code == 200) {
  //       ResponseDogsModel responseDogsModel = ResponseDogsModel.fromJson(response.data);

  //       myRef.read(responseDogsProvider.notifier).set(
  //         responseDogsModel.dogs.map((elem) => ResponseDogsDetailModel.fromJson(elem)).toList(),
  //       );
        
  //       if(!myContext.mounted) return;
  //       // 로딩 끝
  //       hideLoadingDialog(myContext);
  //     } else {
  //       if(!myContext.mounted) return;
  //       // 로딩 끝
  //       hideLoadingDialog(myContext);
  //       // 에러 알림창
  //       showAlertDialog(
  //         context: myContext, 
  //         middleText: "반려동물 조회에 실패했습니다."
  //       );
  //       return;
  //     }
  //   } on DioException catch(e) {
  //     // debugPrint("========== Request Dogs Exception ==========");
  //     // debugPrint(e.toString());

  //     // 로딩 끝
  //     if(!myContext.mounted) return;
  //     hideLoadingDialog(myContext);

  //     // 에러 알림창
  //     showAlertDialog(
  //       context: myContext, 
  //       middleText: Sentence.SERVER_ERR,
  //     );
  //   }
  // }

  Future<void> fnMyPetDeleteExec(int pet_id) async {
    try {
      final response = await myRef.read(petRepositoryProvider).requestDogDeleteRepository(pet_id);
      final storage = myRef.watch(secureStorageProvider);

      if(response.response_code == 200) {
        // 활성화된 반려동물 인덱스 조정
        int homeActivatedPetNav = myRef.read(homeActivatedPetNavProvider.notifier).get();
        if(homeActivatedPetNav != 0) {
          myRef.read(homeActivatedPetNavProvider.notifier).set(0);
          await storage.write(key: ProjectConstant.PET_ACTIVATED_INDEX, value: null);
        }

        if(!myContext.mounted) return;
        // 반려동물 조회
        await ControllerUtils.fnGetDogsExec(myRef, myContext);
        if(!myContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(myContext);
        // 알림창
        showAlertDialog(
          context: myContext, 
          middleText: "반려동물이 삭제되었습니다.",
          barrierDismissible: true,
        );
      } else {
        if(!myContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(myContext);
        // 에러 알림창
        showAlertDialog(
          context: myContext, 
          middleText: "반려동물 삭제에 실패했습니다."
        );
        return;
      }
    } on DioException catch(e) {
      // debugPrint("========== Request Delete Exception ==========");
      // debugPrint(e.toString());

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

  // ########################################
  // 기타 설정
  // ########################################

  // 로그아웃
  Future<void> fnLogOutExec() async {
    // 기존 코드 백업
    final storage = myRef.watch(secureStorageProvider);

    // await storage.write(key: ProjectConstant.ACCESS_TOKEN, value: null);
    // await storage.write(key: ProjectConstant.REFRESH_TOKEN, value: null);
    // await storage.write(key: ProjectConstant.PET_ACTIVATED_INDEX, value: null);

    // myRef.invalidate(responseUserMypageProvider);

    await ControllerUtils.fnInitAppState(myRef); // flutter_secure_storage 삭제
    await ControllerUtils.fnInvalidateAllState(myRef); // provider invalidate

    if(kIsWeb) {
      await ControllerUtils.fnDeleteLocalStorage();
      // 활성화 반려동물 인덱스 0으로 세팅
      await storage.write(key: ProjectConstant.PET_ACTIVATED_INDEX, value: '0');
      myRef.read(homeActivatedPetNavProvider.notifier).set(0);
    }
    
    if(!myContext.mounted) return;
    myContext.goNamed('login_screen');
  }
  // 회원탈퇴
  Future<void> fnSignOutExec() async {
    try {
      final response = await myRef.read(userRepositoryProvider).requestSignoutRepository();

      if(response.response_code == 200) {
        if(!myContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(myContext);
        // 화면 이동
        if(!myContext.mounted) return;
        myContext.goNamed('login_screen');
        // 탈퇴 성공 알림창
        showAlertDialog(
          context: myContext, 
          middleText: "탈퇴가 완료되었습니다.",
          barrierDismissible: false,
        );
      } else {
        if(!myContext.mounted) return;
        // 로딩 끝
        hideLoadingDialog(myContext);
        // 에러 알림창
        showAlertDialog(
          context: myContext, 
          middleText: "탈퇴에 실패했습니다."
        );
        return;
      }
    } on DioException catch(e) {
      // debugPrint("========== Request Signout Dio Exception ==========");
      // debugPrint(e.toString());

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

  // FitBark 앱 호출
  Future<void> fnCallFitBarkApp() async {

    final Uri uri = Uri.parse(ProjectConstant.FITBARK_SCHEME);
    bool opened = await canLaunchUrl(uri);

    if (opened) {
      await launchUrl(uri);
    } else {
      if (Platform.isAndroid) {
        await launchUrl(
          Uri.parse(ProjectConstant.FITBARK_PLAY_STORE_URL), 
          mode: LaunchMode.externalApplication
        );
      } else {
        await launchUrl(
          Uri.parse(ProjectConstant.FITBARK_APP_STORE_URL), 
          mode: LaunchMode.externalApplication
        );
      }
    }
  }
}

  

