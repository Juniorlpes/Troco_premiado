import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/app/app_module.dart';
import 'package:troco_premiado/flavor_config.dart';

Future<void> main() async {
  FlavorConfig(
    flavor: Flavor.dev,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ModularApp(module: AppModule()));
}
