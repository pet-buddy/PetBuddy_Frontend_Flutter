
import 'package:json_annotation/json_annotation.dart';

part 'request_new_dog_model.g.dart';

@JsonSerializable()
class RequestNewDogModel {
  String pet_name;
  String pet_size;
  String division2_code;
  String pet_gender;
  String neuter_yn;
  int feed_id;
  List<String> feed_time;
  String pet_birth;
  String food_remain_grade;

  RequestNewDogModel({
    required this.pet_name,
    required this.pet_size,
    required this.division2_code,
    required this.pet_gender,
    required this.neuter_yn,
    required this.feed_id,
    required this.feed_time,
    required this.pet_birth,
    required this.food_remain_grade,
  });

  factory RequestNewDogModel.fromJson(Map<String, dynamic> json) => _$RequestNewDogModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestNewDogModelToJson(this);
}