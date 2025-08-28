
import 'package:json_annotation/json_annotation.dart';

part 'response_v2_user_mypage_model.g.dart';

@JsonSerializable()
class ResponseV2UserMypageModel {
  int user_id;
  String? user_name;
  String? user_slug;
  String email;
  String user_password;
  String? phone_number;
  String? gender;
  String? interest;
  String? sign_route;
  String? address;
  String? remark;
  String? birth;
  int? user_steps;
  String created_at;
  String? updated_at;
  String createdAt;
  String? updatedAt;

  ResponseV2UserMypageModel({
    required this.user_id,
    this.user_name,
    this.user_slug,
    required this.email,
    required this.user_password,
    this.gender,
    this.interest,
    this.sign_route,
    this.address,
    this.remark,
    this.birth,
    this.user_steps,
    required this.created_at,
    this.updated_at,
    required this.createdAt,
    this.updatedAt,
  });

  factory ResponseV2UserMypageModel.fromJson(Map<String, dynamic> json) => _$ResponseV2UserMypageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseV2UserMypageModelToJson(this);
}