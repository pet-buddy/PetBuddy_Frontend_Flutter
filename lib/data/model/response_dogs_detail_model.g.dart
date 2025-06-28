// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_dogs_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDogsDetailModel _$ResponseDogsDetailModelFromJson(
        Map<String, dynamic> json) =>
    ResponseDogsDetailModel(
      pet_id: (json['pet_id'] as num).toInt(),
      user_id: (json['user_id'] as num).toInt(),
      pet_name: json['pet_name'] as String,
      pet_birth: json['pet_birth'] as String,
      pet_gender: json['pet_gender'] as String,
      pet_size: json['pet_size'] as String,
      neuter_yn: json['neuter_yn'] as bool,
      division2_code: json['division2_code'] as String,
      feed_time: (json['feed_time'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      feed: (json['feed'] as num).toInt(),
      foodGrade: json['foodGrade'] as String?,
    );

Map<String, dynamic> _$ResponseDogsDetailModelToJson(
        ResponseDogsDetailModel instance) =>
    <String, dynamic>{
      'pet_id': instance.pet_id,
      'user_id': instance.user_id,
      'pet_name': instance.pet_name,
      'pet_birth': instance.pet_birth,
      'pet_gender': instance.pet_gender,
      'pet_size': instance.pet_size,
      'neuter_yn': instance.neuter_yn,
      'division2_code': instance.division2_code,
      'feed_time': instance.feed_time,
      'feed': instance.feed,
      'foodGrade': instance.foodGrade,
    };
