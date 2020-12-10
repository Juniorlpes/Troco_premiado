import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:troco_premiado/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/models/company.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initHive();
  runApp(ModularApp(module: AppModule()));
}

Future<void> initHive() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(CompanyAdapter());
}
