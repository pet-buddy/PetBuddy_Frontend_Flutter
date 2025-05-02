
import 'package:json_annotation/json_annotation.dart';

part 'request_email_register_model.g.dart';

@JsonSerializable()
class RequestEmailRegisterModel {
  String name;
  String email;
  String password;

  RequestEmailRegisterModel({
    this.name = '',
    required this.email,
    required this.password,
  });

  factory RequestEmailRegisterModel.fromJson(Map<String, dynamic> json) => _$RequestEmailRegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestEmailRegisterModelToJson(this);
}