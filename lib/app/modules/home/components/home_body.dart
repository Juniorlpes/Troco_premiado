import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/app/modules/home/home_controller.dart';
import 'package:troco_premiado/app/modules/home/widgets/home_card.dart';
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
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          padding: const EdgeInsets.all(10),
          children: [
            HomeCard(
              title: 'Novo Sorteio',
              icon: Icons.monetization_on,
              onTap: () =>
                  Modular.to.pushNamed('/home/addTicket', arguments: false),
            ),
            HomeCard(
                title: 'Ver Pendêntes',
                icon: Icons.pending_actions,
                onTap: () {
                  controller.getPendingTickets();
                  Modular.to.pushNamed('/home/pending');
                }),
            HomeCard(
              title: 'Pré cadastro',
              icon: Icons.person_add,
              onTap: () =>
                  Modular.to.pushNamed('/home/addTicket', arguments: true),
            ),
            HomeCard(
              title: 'Histórico',
              icon: Icons.receipt,
              onTap: () => Modular.to.pushNamed('/home/history'),
            ),
            HomeCard(
              title: 'Log out',
              icon: Icons.exit_to_app,
              onTap: () async {
                showGeneralLoadingPop(context);
                final loggedOut = await controller.logOut();
                Modular.to.pop();
                if (loggedOut) {
                  Modular.to.pushReplacementNamed('/');
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
