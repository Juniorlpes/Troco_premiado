import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/app/modules/home/controllers/history_controller.dart';
import 'package:troco_premiado/app/modules/home/widgets/history_card.dart';
import 'package:troco_premiado/shared/components/commom_animations.dart';
import 'package:troco_premiado/shared/enums/request_status.dart';

class ListTicketComponent extends StatelessWidget {
  final _historyController = Modular.get<HistoryController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_historyController.requestStatus == RequestStatus.Loading) {
          return SimpleLoadingAnimation();
        } else if (_historyController.requestStatus == RequestStatus.Fail) {
          return Center(
            child: Text('Erro ao carregar'),
          );
        } else if (_historyController.ticketList.isEmpty) {
          return Center(
            child: Text('Sem bilhetes'),
          );
        } else {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            separatorBuilder: (_, __) => Container(height: 5),
            itemCount: _historyController.ticketList.length,
            itemBuilder: (_, idx) =>
                HistoryCard(_historyController.ticketList[idx]),
          );
        }
      },
    );
  }
}
