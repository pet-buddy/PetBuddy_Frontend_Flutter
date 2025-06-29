
import 'package:json_annotation/json_annotation.dart';

part 'request_update_dog_model.g.dart';

@JsonSerializable()
class RequestUpdateDogModel {
  String pet_name;
  String pet_size;
  String division2_code;
  String pet_gender;
  bool? neuter_yn;
  int feed_id;
  List<String> feed_time;
  String pet_birth;
  String food_remain_grade;

  RequestUpdateDogModel({
    required this.pet_name,
    required this.pet_size,
    required this.division2_code,
    required this.pet_gender,
    this.neuter_yn,
    required this.feed_id,
    required this.feed_time,
    required this.pet_birth,
    required this.food_remain_grade,
  });

  RequestUpdateDogModel copyWith({
    String? pet_name,
    String? pet_size,
    String? division2_code,
    String? pet_gender,
    bool? neuter_yn,
    int? feed_id,
    List<String>? feed_time,
    String? pet_birth,
    String? food_remain_grade,
  }) {
    return RequestUpdateDogModel(
      pet_name: pet_name ?? this.pet_name,
      pet_size: pet_size ?? this.pet_size,
      division2_code: division2_code ?? this.division2_code,
      pet_gender: pet_gender ?? this.pet_gender,
      neuter_yn: neuter_yn ?? this.neuter_yn,
      feed_id: feed_id ?? this.feed_id,
      feed_time: feed_time ?? this.feed_time,
      pet_birth: pet_birth ?? this.pet_birth,
      food_remain_grade: food_remain_grade ?? this.food_remain_grade,
    );
  }

  factory RequestUpdateDogModel.fromJson(Map<String, dynamic> json) => _$RequestUpdateDogModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestUpdateDogModelToJson(this);
}