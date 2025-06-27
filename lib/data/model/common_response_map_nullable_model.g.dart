// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_response_map_nullable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonResponseMapNullableModel _$CommonResponseMapNullableModelFromJson(
        Map<String, dynamic> json) =>
    CommonResponseMapNullableModel(
      response_code: (json['response_code'] as num).toInt(),
      response_message: json['response_message'] as String,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CommonResponseMapNullableModelToJson(
        CommonResponseMapNullableModel instance) =>
    <String, dynamic>{
      'response_code': instance.response_code,
      'response_message': instance.response_message,
      'data': instance.data,
    };
