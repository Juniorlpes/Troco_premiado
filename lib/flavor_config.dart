import 'package:flutter/foundation.dart';

enum Flavor { dev, prod }

class FlavorConfig {
  final Flavor flavor;
  final String name;
  //final EnvironmentModel env;

  static FlavorConfig _instance;

  factory FlavorConfig({@required Flavor flavor}) {
    _instance ??= FlavorConfig._internal(
        flavor, flavor.toString().replaceAll('Flavor.', ''));

    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.name);

  static FlavorConfig get instance => _instance;

  static bool get isProd => _instance.flavor == Flavor.prod;
  static bool get isDev => _instance.flavor == Flavor.dev;
}
