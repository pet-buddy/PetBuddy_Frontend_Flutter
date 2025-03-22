import 'package:json_annotation/json_annotation.dart';

part 'common_response_map_model.g.dart';

@JsonSerializable()
class CommonResponseMapModel {
  final int response_code;
  final String response_message;
  final Map<String, dynamic> data;

  CommonResponseMapModel({
    required this.response_code,
    required this.response_message,
    required this.data
  });

  factory CommonResponseMapModel.fromJson(Map<String, dynamic> json) => _$CommonResponseMapModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseMapModelToJson(this);
} 