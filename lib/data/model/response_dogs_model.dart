
import 'package:json_annotation/json_annotation.dart';

part 'response_dogs_model.g.dart';

@JsonSerializable()
class ResponseDogsModel {
  List<Map<String, dynamic>> dogs;

  ResponseDogsModel({
    required this.dogs,
  });

  factory ResponseDogsModel.fromJson(Map<String, dynamic> json) => _$ResponseDogsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDogsModelToJson(this);
}