// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_refresh_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseRefreshModel _$ResponseRefreshModelFromJson(
        Map<String, dynamic> json) =>
    ResponseRefreshModel(
      access_token: json['access_token'] as String,
      refresh_token: json['refresh_token'] as String,
    );

Map<String, dynamic> _$ResponseRefreshModelToJson(
        ResponseRefreshModel instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
    };
