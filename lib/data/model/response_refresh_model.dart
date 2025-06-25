
import 'package:json_annotation/json_annotation.dart';

part 'response_refresh_model.g.dart';

@JsonSerializable()
class ResponseRefreshModel {
  final String access_token;
  final String refresh_token;

  ResponseRefreshModel({
    required this.access_token,
    required this.refresh_token,
  });

  factory ResponseRefreshModel.fromJson(Map<String, dynamic> json) => _$ResponseRefreshModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseRefreshModelToJson(this);
}