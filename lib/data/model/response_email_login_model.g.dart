// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_email_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseEmailLoginModel _$ResponseEmailLoginModelFromJson(
        Map<String, dynamic> json) =>
    ResponseEmailLoginModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$ResponseEmailLoginModelToJson(
        ResponseEmailLoginModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
