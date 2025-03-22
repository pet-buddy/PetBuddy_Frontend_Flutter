import 'package:json_annotation/json_annotation.dart';

part 'common_response_list_model.g.dart';

@JsonSerializable()
class CommonResponseListModel {
  final int response_code;
  final String response_message;
  final List<dynamic>? data;

  CommonResponseListModel({
    required this.response_code,
    required this.response_message,
    this.data
  });

  factory CommonResponseListModel.fromJson(Map<String, dynamic> json) => _$CommonResponseListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseListModelToJson(this);
} 