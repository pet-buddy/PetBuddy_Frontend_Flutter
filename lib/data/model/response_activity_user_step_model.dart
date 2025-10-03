import 'package:json_annotation/json_annotation.dart';

part 'response_activity_user_step_model.g.dart';

@JsonSerializable()
class ResponseActivityUserStepModel {
  final int response_code;
  final String response_message;
  final int? data;

  ResponseActivityUserStepModel({
    required this.response_code,
    required this.response_message,
    this.data
  });

  factory ResponseActivityUserStepModel.fromJson(Map<String, dynamic> json) => _$ResponseActivityUserStepModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseActivityUserStepModelToJson(this);
} 