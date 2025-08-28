
import 'package:json_annotation/json_annotation.dart';

part 'response_v2_dogs_model.g.dart';

@JsonSerializable()
class ResponseV2DogsModel {
  List<Map<String, dynamic>> dogs;

  ResponseV2DogsModel({
    required this.dogs,
  });

  factory ResponseV2DogsModel.fromJson(Map<String, dynamic> json) => _$ResponseV2DogsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseV2DogsModelToJson(this);
}