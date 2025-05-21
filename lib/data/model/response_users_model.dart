
import 'package:json_annotation/json_annotation.dart';

part 'response_users_model.g.dart';

@JsonSerializable()
class ResponseUsersModel {
  String gender;
  String interest;
  String phone_number;
  String birth;

  ResponseUsersModel({
    required this.gender,
    required this.interest,
    required this.phone_number,
    required this.birth,
  });

  factory ResponseUsersModel.fromJson(Map<String, dynamic> json) => _$ResponseUsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseUsersModelToJson(this);
}