
import 'package:json_annotation/json_annotation.dart';

part 'request_user_step_model.g.dart';

@JsonSerializable()
class RequestUserStepModel {
  final int step;

  RequestUserStepModel({
    required this.step,
  });

  factory RequestUserStepModel.fromJson(Map<String, dynamic> json) => _$RequestUserStepModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestUserStepModelToJson(this);
}