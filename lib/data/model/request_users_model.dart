
import 'package:json_annotation/json_annotation.dart';

part 'request_users_model.g.dart';

@JsonSerializable()
class RequestUsersModel {
  String sex;
  String interest;
  String phone_number;
  String birth;

  RequestUsersModel({
    required this.sex,
    required this.interest,
    required this.phone_number,
    required this.birth,
  });

  factory RequestUsersModel.fromJson(Map<String, dynamic> json) => _$RequestUsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestUsersModelToJson(this);
}