
import 'package:json_annotation/json_annotation.dart';

part 'response_activity_daily_status_model.g.dart';

@JsonSerializable()
class ResponseActivityDailyStatusModel {
  String date;
  int activity_value;
  int min_play;
  int min_active;
  int min_rest;
  int daily_target;
  int has_trophy;

  ResponseActivityDailyStatusModel({
    required this.date,
    required this.activity_value,
    required this.min_play,
    required this.min_active,
    required this.min_rest,
    required this.daily_target,
    required this.has_trophy,
  });

  factory ResponseActivityDailyStatusModel.fromJson(Map<String, dynamic> json) => _$ResponseActivityDailyStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseActivityDailyStatusModelToJson(this);
}
