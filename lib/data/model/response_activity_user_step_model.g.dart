// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_activity_user_step_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseActivityUserStepModel _$ResponseActivityUserStepModelFromJson(
        Map<String, dynamic> json) =>
    ResponseActivityUserStepModel(
      response_code: (json['response_code'] as num).toInt(),
      response_message: json['response_message'] as String,
      data: (json['data'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ResponseActivityUserStepModelToJson(
        ResponseActivityUserStepModel instance) =>
    <String, dynamic>{
      'response_code': instance.response_code,
      'response_message': instance.response_message,
      'data': instance.data,
    };
