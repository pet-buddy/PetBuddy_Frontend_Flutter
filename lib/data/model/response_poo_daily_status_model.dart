
import 'package:json_annotation/json_annotation.dart';

part 'response_poo_daily_status_model.g.dart';

@JsonSerializable()
class ResponsePooDailyStatusModel {
  String poop_date;
  String poop_url;
  int poop_score_total;
  int poop_score_moisture;
  int poop_score_color;
  int poop_score_parasite;

  ResponsePooDailyStatusModel({
    required this.poop_date,
    required this.poop_url,
    required this.poop_score_total,
    required this.poop_score_moisture,
    required this.poop_score_color,
    required this.poop_score_parasite,
  });

  factory ResponsePooDailyStatusModel.fromJson(Map<String, dynamic> json) => _$ResponsePooDailyStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePooDailyStatusModelToJson(this);
}