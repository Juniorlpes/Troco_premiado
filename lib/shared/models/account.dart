import 'package:json_annotation/json_annotation.dart';
import 'package:troco_premiado/shared/enums/e_user_type.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  bool active;
  String companyId;
  String email;
  String id;
  String name;
  EUserType userType;

  Account({this.email, this.name}) {
    this.active = false;
    this.userType = EUserType.DEFAULT;
  }

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
