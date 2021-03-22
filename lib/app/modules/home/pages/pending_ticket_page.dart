import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/app/modules/home/home_controller.dart';
import 'package:troco_premiado/app/modules/home/widgets/pending_card.dart';
import 'package:troco_premiado/shared/components/commom_animations.dart';
import 'package:troco_premiado/shared/enums/request_status.dart';

class PendingTicketPage extends StatelessWidget {
  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bilhetes pendêntes'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: controller.getPendingTickets,
          child: Observer(
            builder: (context) {
              if (controller.pendingRequestStatus == RequestStatus.None)
                return Center(child: SimpleLoadingAnimation());
              else if (controller.pendingRequestStatus == RequestStatus.Loading)
                return Center(child: SimpleLoadingAnimation());
              else if (controller.pendingRequestStatus == RequestStatus.Fail)
                return Center(child: Text('Erro ao buscar lista'));
              else if (controller.pendingTicketList.isEmpty)
                return Center(child: Text('Sem bilhetes pendentes'));
              else
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: controller.pendingTicketList.length,
                  itemBuilder: (_, idx) =>
                      PendingCard(ticket: controller.pendingTicketList[idx]),
                );
            },
          ),
        ));
  }
}
