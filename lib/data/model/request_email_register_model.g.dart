// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_email_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestEmailRegisterModel _$RequestEmailRegisterModelFromJson(
        Map<String, dynamic> json) =>
    RequestEmailRegisterModel(
      name: json['name'] as String? ?? '',
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RequestEmailRegisterModelToJson(
        RequestEmailRegisterModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
    };
