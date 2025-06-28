// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_update_dog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestUpdateDogModel _$RequestUpdateDogModelFromJson(
        Map<String, dynamic> json) =>
    RequestUpdateDogModel(
      pet_name: json['pet_name'] as String,
      pet_size: json['pet_size'] as String,
      division2_code: json['division2_code'] as String,
      pet_gender: json['pet_gender'] as String,
      neuter_yn: json['neuter_yn'] as bool?,
      feed_id: (json['feed_id'] as num).toInt(),
      feed_time:
          (json['feed_time'] as List<dynamic>).map((e) => e as String).toList(),
      pet_birth: json['pet_birth'] as String,
      food_remain_grade: json['food_remain_grade'] as String,
    );

Map<String, dynamic> _$RequestUpdateDogModelToJson(
        RequestUpdateDogModel instance) =>
    <String, dynamic>{
      'pet_name': instance.pet_name,
      'pet_size': instance.pet_size,
      'division2_code': instance.division2_code,
      'pet_gender': instance.pet_gender,
      'neuter_yn': instance.neuter_yn,
      'feed_id': instance.feed_id,
      'feed_time': instance.feed_time,
      'pet_birth': instance.pet_birth,
      'food_remain_grade': instance.food_remain_grade,
    };
