
import 'package:json_annotation/json_annotation.dart';

part 'response_activity_hourly_status_model.g.dart';

@JsonSerializable()
class ResponseActivityHourlyStatusModel {
  String date;
  int activity_value;
  int min_play;
  int min_active;
  int min_rest;
  double? distance_in_miles;
  int? kcalories;
  int? activity_goal;

  ResponseActivityHourlyStatusModel({
    required this.date,
    required this.activity_value,
    required this.min_play,
    required this.min_active,
    required this.min_rest,
    this.distance_in_miles,
    this.kcalories,
    this.activity_goal,
  });

  factory ResponseActivityHourlyStatusModel.fromJson(Map<String, dynamic> json) => _$ResponseActivityHourlyStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseActivityHourlyStatusModelToJson(this);
}
