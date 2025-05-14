
import 'package:json_annotation/json_annotation.dart';

part 'response_user_mypage_model.g.dart';

@JsonSerializable()
class ResponseUserMypageModel {
  int user_id;
  String? user_name;
  String email;
  String user_password;
  String? phone_number;
  String? gender;
  String? interest;
  String? sign_route;
  String? address;
  String? remark;
  String? birth;
  String created_at;
  String? updated_at;
  String createdAt;
  String? updatedAt;

  ResponseUserMypageModel({
    required this.user_id,
    this.user_name,
    required this.email,
    required this.user_password,
    this.gender,
    this.interest,
    this.sign_route,
    this.address,
    this.remark,
    this.birth,
    required this.created_at,
    this.updated_at,
    required this.createdAt,
    this.updatedAt,
  });

  factory ResponseUserMypageModel.fromJson(Map<String, dynamic> json) => _$ResponseUserMypageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseUserMypageModelToJson(this);
}