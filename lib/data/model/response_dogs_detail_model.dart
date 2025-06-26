
import 'package:json_annotation/json_annotation.dart';

part 'response_dogs_detail_model.g.dart';

@JsonSerializable()
class ResponseDogsDetailModel {
  int pet_id;
  int user_id;
  String pet_name;
  String pet_birth;
  String pet_gender;
  String pet_size;
  bool neuter_yn;
  String division2_code;
  String createdAt;
  String updatedAt;
  Map<String, dynamic> owner;

  ResponseDogsDetailModel({
    required this.pet_id,
    required this.user_id,
    required this.pet_name,
    required this.pet_birth,
    required this.pet_gender,
    required this.pet_size,
    required this.neuter_yn,
    required this.division2_code,
    required this.createdAt,
    required this.updatedAt,
    required this.owner,
  });

  factory ResponseDogsDetailModel.fromJson(Map<String, dynamic> json) => _$ResponseDogsDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDogsDetailModelToJson(this);
}
