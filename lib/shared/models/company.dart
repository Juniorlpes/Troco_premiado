import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:troco_premiado/shared/cache/cache_adapters_id.dart';

part 'company.g.dart';

@JsonSerializable()
@HiveType(typeId: CacheAdaptersId.CompanyAdapter)
class Company {
  @HiveField(0)
  String address;
  @HiveField(1)
  int id;
  @HiveField(2)
  double latitude;
  @HiveField(3)
  double longitude;
  @HiveField(4)
  String name;
  @HiveField(5)
  int luckyArea;

  Company(
      {this.address,
      this.id,
      this.latitude,
      this.longitude,
      this.name,
      this.luckyArea});

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
