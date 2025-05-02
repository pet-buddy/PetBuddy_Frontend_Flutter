
import 'package:json_annotation/json_annotation.dart';

part 'request_email_login_model.g.dart';

@JsonSerializable()
class RequestEmailLoginModel {
  String email;
  String password;

  RequestEmailLoginModel({
    required this.email,
    required this.password,
  });

  factory RequestEmailLoginModel.fromJson(Map<String, dynamic> json) => _$RequestEmailLoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestEmailLoginModelToJson(this);
}