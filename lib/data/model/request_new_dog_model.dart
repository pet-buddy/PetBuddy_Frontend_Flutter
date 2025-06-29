
import 'package:json_annotation/json_annotation.dart';

part 'request_new_dog_model.g.dart';

@JsonSerializable()
class RequestNewDogModel {
  String pet_name;
  String pet_size;
  String division2_code;
  String pet_gender;
  bool? neuter_yn;
  int feed_id;
  List<String> feed_time;
  String pet_birth;
  String food_remain_grade;

  RequestNewDogModel({
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

  RequestNewDogModel copyWith({
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
    return RequestNewDogModel(
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

  factory RequestNewDogModel.fromJson(Map<String, dynamic> json) => _$RequestNewDogModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestNewDogModelToJson(this);
}