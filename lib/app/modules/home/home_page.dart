import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/app/modules/home/components/home_body.dart';
import 'package:troco_premiado/app/modules/home/widgets/inactive_account_widget.dart';
import 'package:troco_premiado/shared/components/commom_animations.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final Account mainAccount;
  const HomePage(this.mainAccount);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  void initState() {
    super.initState();
    print(widget.mainAccount.toJson());
    controller.setAccount(widget.mainAccount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bem-vindo, ${widget.mainAccount.name}',
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Observer(
            builder: (_) => (!controller.mainAccount.active)
                ? IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => SimpleLoadingAnimation(isWhite: true),
                      );
                      await controller.getAccountUpdated();
                      Modular.to.pop();
                    },
                  )
                : Container(width: 1),
          )
        ],
      ),
      body: Observer(
        builder: (_) => (!controller.mainAccount.active)
            ? InactiveAccountWidget()
            : HomeBody(),
      ),
    );
  }
}
