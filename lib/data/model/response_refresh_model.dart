
import 'package:json_annotation/json_annotation.dart';

part 'response_refresh_model.g.dart';

@JsonSerializable()
class ResponseRefreshModel {
  final String accessToken;
  final String refreshToken;

  ResponseRefreshModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory ResponseRefreshModel.fromJson(Map<String, dynamic> json) => _$ResponseRefreshModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseRefreshModelToJson(this);
}