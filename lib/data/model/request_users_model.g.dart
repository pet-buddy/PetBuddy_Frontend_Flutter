// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_users_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestUsersModel _$RequestUsersModelFromJson(Map<String, dynamic> json) =>
    RequestUsersModel(
      sex: json['sex'] as String,
      interest: json['interest'] as String,
      phone_number: json['phone_number'] as String,
      birth: json['birth'] as String,
    );

Map<String, dynamic> _$RequestUsersModelToJson(RequestUsersModel instance) =>
    <String, dynamic>{
      'sex': instance.sex,
      'interest': instance.interest,
      'phone_number': instance.phone_number,
      'birth': instance.birth,
    };
