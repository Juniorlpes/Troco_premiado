import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:troco_premiado/shared/cache/cache_adapters_id.dart';

part 'e_user_type.g.dart';

@HiveType(typeId: CacheAdaptersId.EUserTypeAdapter)
enum EUserType {
  @HiveField(0)
  @JsonValue(1)
  DEFAULT,

  @HiveField(1)
  @JsonValue(2)
  COMPANY_OWNER,

  @HiveField(2)
  @JsonValue(3)
  ADMIN,
}
