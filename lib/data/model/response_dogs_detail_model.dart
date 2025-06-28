
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
  List<String>? feed_time;
  int feed;
  String? foodGrade;

  ResponseDogsDetailModel({
    required this.pet_id,
    required this.user_id,
    required this.pet_name,
    required this.pet_birth,
    required this.pet_gender,
    required this.pet_size,
    required this.neuter_yn,
    required this.division2_code,
    this.feed_time,
    required this.feed,
    this.foodGrade,
  });

  factory ResponseDogsDetailModel.fromJson(Map<String, dynamic> json) => _$ResponseDogsDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDogsDetailModelToJson(this);
}
