// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_poo_daily_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePooDailyStatusModel _$ResponsePooDailyStatusModelFromJson(
        Map<String, dynamic> json) =>
    ResponsePooDailyStatusModel(
      poop_date: json['poop_date'] as String,
      poop_url: json['poop_url'] as String,
      poop_score_total: (json['poop_score_total'] as num).toInt(),
      poop_score_moisture: (json['poop_score_moisture'] as num).toInt(),
      poop_score_color: (json['poop_score_color'] as num).toInt(),
      poop_score_parasite: (json['poop_score_parasite'] as num).toInt(),
    );

Map<String, dynamic> _$ResponsePooDailyStatusModelToJson(
        ResponsePooDailyStatusModel instance) =>
    <String, dynamic>{
      'poop_date': instance.poop_date,
      'poop_url': instance.poop_url,
      'poop_score_total': instance.poop_score_total,
      'poop_score_moisture': instance.poop_score_moisture,
      'poop_score_color': instance.poop_score_color,
      'poop_score_parasite': instance.poop_score_parasite,
    };
