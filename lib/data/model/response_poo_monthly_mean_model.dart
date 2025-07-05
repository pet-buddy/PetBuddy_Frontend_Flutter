
import 'package:json_annotation/json_annotation.dart';

part 'response_poo_monthly_mean_model.g.dart';

@JsonSerializable()
class ResponsePooMonthlyMeanModel {
  List<dynamic> monthly_poop_list;
  int? poop_score_total;
  int? poop_score_moisture;
  int? poop_score_color;
  int? poop_score_parasite;

  ResponsePooMonthlyMeanModel({
    required this.monthly_poop_list,
    this.poop_score_total,
    this.poop_score_moisture,
    this.poop_score_color,
    this.poop_score_parasite,
  });

  factory ResponsePooMonthlyMeanModel.fromJson(Map<String, dynamic> json) => _$ResponsePooMonthlyMeanModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponsePooMonthlyMeanModelToJson(this);
}