// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_poo_monthly_mean_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponsePooMonthlyMeanModel _$ResponsePooMonthlyMeanModelFromJson(
        Map<String, dynamic> json) =>
    ResponsePooMonthlyMeanModel(
      monthly_poop_list: json['monthly_poop_list'] as List<dynamic>,
      poop_score_total: (json['poop_score_total'] as num?)?.toInt(),
      poop_score_moisture: (json['poop_score_moisture'] as num?)?.toInt(),
      poop_score_color: (json['poop_score_color'] as num?)?.toInt(),
      poop_score_parasite: (json['poop_score_parasite'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ResponsePooMonthlyMeanModelToJson(
        ResponsePooMonthlyMeanModel instance) =>
    <String, dynamic>{
      'monthly_poop_list': instance.monthly_poop_list,
      'poop_score_total': instance.poop_score_total,
      'poop_score_moisture': instance.poop_score_moisture,
      'poop_score_color': instance.poop_score_color,
      'poop_score_parasite': instance.poop_score_parasite,
    };
