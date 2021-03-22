import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:troco_premiado/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ModularApp(module: AppModule()));
}
