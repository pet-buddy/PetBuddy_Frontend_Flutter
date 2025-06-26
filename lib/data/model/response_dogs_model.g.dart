// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_dogs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDogsModel _$ResponseDogsModelFromJson(Map<String, dynamic> json) =>
    ResponseDogsModel(
      dogs: (json['dogs'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ResponseDogsModelToJson(ResponseDogsModel instance) =>
    <String, dynamic>{
      'dogs': instance.dogs,
    };
