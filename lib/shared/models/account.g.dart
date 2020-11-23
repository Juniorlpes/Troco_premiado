// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account()
    ..active = json['active'] as bool
    ..company = json['company'] as String
    ..idCompany = json['idCompany'] as int
    ..email = json['email'] as String
    ..id = json['id'] as int
    ..name = json['name'] as String;
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'active': instance.active,
      'company': instance.company,
      'idCompany': instance.idCompany,
      'email': instance.email,
      'id': instance.id,
      'name': instance.name,
    };
