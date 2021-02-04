import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/app/modules/home/home_controller.dart';
import 'package:troco_premiado/shared/components/general_loading_pop.dart';

class HomeBody extends StatelessWidget {
  final controller = Modular.get<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.count(
          crossAxisCount: 3,
          primary: false,
          scrollDirection: Axis.vertical,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: const EdgeInsets.all(10),
          children: [
            Card(
              child: InkWell(
                onTap: () => Modular.to.pushNamed('/home/addTicket'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.monetization_on,
                      size: 28,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Novo Sorteio',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.receipt,
                      size: 28,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Histórico',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () async {
                  showGeneralLoadingPop(context);
                  final loggedOut = await controller.logOut();
                  Modular.to.pop();
                  if (loggedOut) {
                    Modular.to.pushReplacementNamed('/');
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.exit_to_app,
                      size: 28,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Log out',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
