// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_userinfos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestUserinfosModel _$RequestUserinfosModelFromJson(
        Map<String, dynamic> json) =>
    RequestUserinfosModel(
      sex: json['sex'] as String,
      interest: json['interest'] as String,
      phone_number: json['phone_number'] as String,
      sign_route: json['sign_route'] as String? ?? '',
      birth: json['birth'] as String,
    );

Map<String, dynamic> _$RequestUserinfosModelToJson(
        RequestUserinfosModel instance) =>
    <String, dynamic>{
      'sex': instance.sex,
      'interest': instance.interest,
      'phone_number': instance.phone_number,
      'sign_route': instance.sign_route,
      'birth': instance.birth,
    };
