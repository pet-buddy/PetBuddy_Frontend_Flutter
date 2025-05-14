// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_user_mypage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseUserMypageModel _$ResponseUserMypageModelFromJson(
        Map<String, dynamic> json) =>
    ResponseUserMypageModel(
      user_id: (json['user_id'] as num).toInt(),
      user_name: json['user_name'] as String?,
      email: json['email'] as String,
      user_password: json['user_password'] as String,
      gender: json['gender'] as String?,
      interest: json['interest'] as String?,
      sign_route: json['sign_route'] as String?,
      address: json['address'] as String?,
      remark: json['remark'] as String?,
      birth: json['birth'] as String?,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
    )..phone_number = json['phone_number'] as String?;

Map<String, dynamic> _$ResponseUserMypageModelToJson(
        ResponseUserMypageModel instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'user_name': instance.user_name,
      'email': instance.email,
      'user_password': instance.user_password,
      'phone_number': instance.phone_number,
      'gender': instance.gender,
      'interest': instance.interest,
      'sign_route': instance.sign_route,
      'address': instance.address,
      'remark': instance.remark,
      'birth': instance.birth,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
