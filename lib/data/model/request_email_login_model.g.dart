// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_email_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestEmailLoginModel _$RequestEmailLoginModelFromJson(
        Map<String, dynamic> json) =>
    RequestEmailLoginModel(
      name: json['name'] as String? ?? '',
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RequestEmailLoginModelToJson(
        RequestEmailLoginModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
    };
