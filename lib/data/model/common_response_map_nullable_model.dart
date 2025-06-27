import 'package:json_annotation/json_annotation.dart';

part 'common_response_map_nullable_model.g.dart';

@JsonSerializable()
class CommonResponseMapNullableModel {
  final int response_code;
  final String response_message;
  final Map<String, dynamic>? data;

  CommonResponseMapNullableModel({
    required this.response_code,
    required this.response_message,
    this.data
  });

  factory CommonResponseMapNullableModel.fromJson(Map<String, dynamic> json) => _$CommonResponseMapNullableModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseMapNullableModelToJson(this);
} 