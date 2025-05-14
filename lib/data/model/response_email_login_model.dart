
import 'package:json_annotation/json_annotation.dart';

part 'response_email_login_model.g.dart';

@JsonSerializable()
class ResponseEmailLoginModel {
  String accessToken;
  String refreshToken;

  ResponseEmailLoginModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory ResponseEmailLoginModel.fromJson(Map<String, dynamic> json) => _$ResponseEmailLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseEmailLoginModelToJson(this);
}