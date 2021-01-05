import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final Account mainAccount;
  const HomePage(this.mainAccount);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    print(widget.mainAccount.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
