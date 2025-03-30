// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_my_profile_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMyProfileUpdateModel _$RequestMyProfileUpdateModelFromJson(
        Map<String, dynamic> json) =>
    RequestMyProfileUpdateModel(
      gender: json['gender'] as String,
      birth: json['birth'] as String,
      healthInfo: json['healthInfo'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$RequestMyProfileUpdateModelToJson(
        RequestMyProfileUpdateModel instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'birth': instance.birth,
      'healthInfo': instance.healthInfo,
      'phone': instance.phone,
    };
