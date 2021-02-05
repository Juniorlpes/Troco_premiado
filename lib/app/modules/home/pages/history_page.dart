import 'package:flutter/material.dart';
import 'package:troco_premiado/app/modules/home/widgets/history_card.dart';
import 'package:troco_premiado/shared/cache/cache_box_enum.dart';
import 'package:troco_premiado/shared/cache/cache_controller.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';

class HistoryPage extends StatelessWidget {
  final cacheRaffles =
      CacheController<TicketRaffle>(cacheBoxEnum: CacheBox.Raffle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de bilhetes'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<TicketRaffle>>(
        future: getHistoryList(),
        builder: (_, snap) {
          switch (snap.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snap.hasError) {
                return Center(child: Text('Erro ao Carregar'));
              } else {
                if (snap.data.isEmpty) {
                  return Center(child: Text('Sem dados para exibir'));
                } else {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    separatorBuilder: (_, __) => const SizedBox(height: 5),
                    itemCount: snap.data.length,
                    itemBuilder: (_, idx) => HistoryCard(snap.data[idx]),
                  );
                }
              }
          }
        },
      ),
    );
  }

  Future<List<TicketRaffle>> getHistoryList() async {
    var list = await cacheRaffles.values;
    return list.toList();
  }
}
