// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_v2_dogs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseV2DogsModel _$ResponseV2DogsModelFromJson(Map<String, dynamic> json) =>
    ResponseV2DogsModel(
      dogs: (json['dogs'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ResponseV2DogsModelToJson(
        ResponseV2DogsModel instance) =>
    <String, dynamic>{
      'dogs': instance.dogs,
    };
