// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_activity_daily_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseActivityDailyStatusModel _$ResponseActivityDailyStatusModelFromJson(
        Map<String, dynamic> json) =>
    ResponseActivityDailyStatusModel(
      date: json['date'] as String,
      activity_value: (json['activity_value'] as num).toInt(),
      min_play: (json['min_play'] as num).toInt(),
      min_active: (json['min_active'] as num).toInt(),
      min_rest: (json['min_rest'] as num).toInt(),
      daily_target: (json['daily_target'] as num).toInt(),
      has_trophy: (json['has_trophy'] as num).toInt(),
    );

Map<String, dynamic> _$ResponseActivityDailyStatusModelToJson(
        ResponseActivityDailyStatusModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'activity_value': instance.activity_value,
      'min_play': instance.min_play,
      'min_active': instance.min_active,
      'min_rest': instance.min_rest,
      'daily_target': instance.daily_target,
      'has_trophy': instance.has_trophy,
    };
