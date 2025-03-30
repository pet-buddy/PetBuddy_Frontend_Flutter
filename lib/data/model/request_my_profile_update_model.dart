
import 'package:json_annotation/json_annotation.dart';

part 'request_my_profile_update_model.g.dart';

@JsonSerializable()
class RequestMyProfileUpdateModel {
  String gender;
  String birth;
  String healthInfo;
  String phone;

  RequestMyProfileUpdateModel({
    required this.gender,
    required this.birth,
    required this.healthInfo,
    required this.phone,
  });

  factory RequestMyProfileUpdateModel.fromJson(Map<String, dynamic> json) => _$RequestMyProfileUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestMyProfileUpdateModelToJson(this);
}