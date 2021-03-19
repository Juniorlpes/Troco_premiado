// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    email: json['email'] as String,
    name: json['name'] as String,
  )
    ..active = json['active'] as bool
    ..companyId = json['companyId'] as String
    ..id = json['id'] as String
    ..userType = _$enumDecodeNullable(_$EUserTypeEnumMap, json['userType']);
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'active': instance.active,
      'companyId': instance.companyId,
      'email': instance.email,
      'id': instance.id,
      'name': instance.name,
      'userType': _$EUserTypeEnumMap[instance.userType],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$EUserTypeEnumMap = {
  EUserType.DEFAULT: 1,
  EUserType.COMPANY_OWNER: 2,
  EUserType.ADMIN: 3,
};
