
import 'package:json_annotation/json_annotation.dart';

part 'request_userinfos_model.g.dart';

@JsonSerializable()
class RequestUserinfosModel {
  String sex;
  String interest;
  String phone_number;
  String sign_route;
  String birth;

  RequestUserinfosModel({
    required this.sex,
    required this.interest,
    required this.phone_number,
    this.sign_route = '',
    required this.birth,
  });

  factory RequestUserinfosModel.fromJson(Map<String, dynamic> json) => _$RequestUserinfosModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestUserinfosModelToJson(this);
}