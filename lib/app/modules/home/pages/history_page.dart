import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:troco_premiado/app/modules/home/controllers/history_controller.dart';

class HistoryPage extends StatelessWidget {
  final historyController = HistoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de bilhetes'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getBody(),
        ),
      ),
    );
  }

  List<Widget> _getBody() {
    List<Widget> children = <Widget>[];

    children.add(Container(
      width: double.infinity,
      child: Text(
        'Periodo 0${historyController.period} de ${DateTime.now().year}',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));

    var startSubList = 0;
    for (var i = 0; i < 4; i++) {
      children.add(Text(
        historyController.getMounthName(i),
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ));
      children.addAll(historyController.raffleDates
          .sublist(startSubList, startSubList + 2)
          .map<Widget>(
            (date) => ListTile(
              title: Text(DateFormat('dd/MM/yyyy').format(date)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          )
          .toList());
      startSubList += 2;
    }

    return children;
  }
}
