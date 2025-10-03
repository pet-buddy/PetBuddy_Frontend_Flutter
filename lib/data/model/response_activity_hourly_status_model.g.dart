// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_activity_hourly_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseActivityHourlyStatusModel _$ResponseActivityHourlyStatusModelFromJson(
        Map<String, dynamic> json) =>
    ResponseActivityHourlyStatusModel(
      date: json['date'] as String,
      activity_value: (json['activity_value'] as num).toInt(),
      min_play: (json['min_play'] as num).toInt(),
      min_active: (json['min_active'] as num).toInt(),
      min_rest: (json['min_rest'] as num).toInt(),
      distance_in_miles: (json['distance_in_miles'] as num?)?.toDouble(),
      kcalories: (json['kcalories'] as num?)?.toInt(),
      activity_goal: (json['activity_goal'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ResponseActivityHourlyStatusModelToJson(
        ResponseActivityHourlyStatusModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'activity_value': instance.activity_value,
      'min_play': instance.min_play,
      'min_active': instance.min_active,
      'min_rest': instance.min_rest,
      'distance_in_miles': instance.distance_in_miles,
      'kcalories': instance.kcalories,
      'activity_goal': instance.activity_goal,
    };
