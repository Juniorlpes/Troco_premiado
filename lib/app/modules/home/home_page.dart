import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/app/modules/home/components/home_body.dart';
import 'package:troco_premiado/app/modules/home/widgets/inactive_account_widget.dart';
import 'package:troco_premiado/shared/components/general_loading_pop.dart';
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
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 60),
        child: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bem-vindo, ${widget.mainAccount.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Observer(
                builder: (_) => Text(
                  controller.mainCompany?.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, color: Colors.white60),
                ),
              )
            ],
          ),
          actions: [
            Observer(
              builder: (_) => (!controller.mainAccount.active)
                  ? IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () async {
                        showGeneralLoadingPop(context);
                        await controller.getAccountUpdated();
                        Modular.to.pop();
                      },
                    )
                  : Container(width: 1),
            )
          ],
        ),
      ),
      body: Observer(
        builder: (_) {
          if (!controller.mainAccount.active) {
            return InactiveAccountWidget();
          } else {
            controller.getMainCompany();
            return HomeBody();
          }
        },
      ),
    );
  }
}
