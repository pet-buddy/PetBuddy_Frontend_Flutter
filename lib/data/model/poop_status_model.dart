import 'package:json_annotation/json_annotation.dart';

part 'poop_status_model.g.dart';

@JsonSerializable()
class PoopStatusModel {
  final String date;
  final String grade;

  PoopStatusModel({
    required this.date,
    required this.grade,
  });

  factory PoopStatusModel.fromJson(Map<String, dynamic> json) => _$PoopStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$PoopStatusModelToJson(this);
} 