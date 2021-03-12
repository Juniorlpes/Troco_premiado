import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:troco_premiado/shared/cache/cache_adapters_id.dart';

part 'account.g.dart';

@JsonSerializable()
@HiveType(typeId: CacheAdaptersId.AccountAdapter)
class Account {
  @HiveField(0)
  bool active;
  @HiveField(1)
  String companyId;
  @HiveField(2)
  String email;
  @HiveField(3)
  String id;
  @HiveField(4)
  String name;

  Account({this.active, this.companyId, this.email, this.id, this.name});

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
