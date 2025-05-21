// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_users_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseUsersModel _$ResponseUsersModelFromJson(Map<String, dynamic> json) =>
    ResponseUsersModel(
      gender: json['gender'] as String,
      interest: json['interest'] as String,
      phone_number: json['phone_number'] as String,
      birth: json['birth'] as String,
    );

Map<String, dynamic> _$ResponseUsersModelToJson(ResponseUsersModel instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'interest': instance.interest,
      'phone_number': instance.phone_number,
      'birth': instance.birth,
    };
