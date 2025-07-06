// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_refresh_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseRefreshModel _$ResponseRefreshModelFromJson(
        Map<String, dynamic> json) =>
    ResponseRefreshModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$ResponseRefreshModelToJson(
        ResponseRefreshModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
