
import 'package:json_annotation/json_annotation.dart';

part 'request_users_model.g.dart';

@JsonSerializable()
class RequestUsersModel {
  String gender;
  String interest;
  String phone_number;
  String birth;

  RequestUsersModel({
    required this.gender,
    required this.interest,
    required this.phone_number,
    required this.birth,
  });

  RequestUsersModel copyWith({
    String? gender,
    String? birth,
    String? interest,
    String? phone_number,
  }) {
    return RequestUsersModel(
      gender: gender ?? this.gender,
      birth: birth ?? this.birth,
      interest: interest ?? this.interest,
      phone_number: phone_number ?? this.phone_number,
    );
  }

  factory RequestUsersModel.fromJson(Map<String, dynamic> json) => _$RequestUsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestUsersModelToJson(this);
}