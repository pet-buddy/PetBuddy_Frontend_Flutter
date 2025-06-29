// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_response_map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonResponseMapModel _$CommonResponseMapModelFromJson(
        Map<String, dynamic> json) =>
    CommonResponseMapModel(
      response_code: (json['response_code'] as num).toInt(),
      response_message: json['response_message'] as String,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CommonResponseMapModelToJson(
        CommonResponseMapModel instance) =>
    <String, dynamic>{
      'response_code': instance.response_code,
      'response_message': instance.response_message,
      'data': instance.data,
    };
