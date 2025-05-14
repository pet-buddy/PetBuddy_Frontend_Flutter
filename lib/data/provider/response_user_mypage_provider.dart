import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petbuddy_frontend_flutter/data/model/response_user_mypage_model.dart';

class ResponseUserMypageState extends StateNotifier<ResponseUserMypageModel> {
  ResponseUserMypageState() : super(ResponseUserMypageModel(
    user_id: -1,
    user_name: null,
    email: "",
    user_password: "",
    gender: null,
    interest: null,
    sign_route: null,
    address: null,
    remark: null,
    birth: null,
    created_at: "",
    updated_at: null,
    createdAt: "",
    updatedAt: null,
  ));

  void set(ResponseUserMypageModel responseUserMypageModel) {
    state = responseUserMypageModel;
  }

  ResponseUserMypageModel get() {
    return state;
  }
}

final responseUserMypageProvider = 
    StateNotifierProvider<ResponseUserMypageState, ResponseUserMypageModel>((ref) => ResponseUserMypageState());