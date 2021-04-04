import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:troco_premiado/app/modules/home/components/list_tickets_component.dart';
import 'package:troco_premiado/app/modules/home/controllers/history_controller.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  final historyController = Modular.get<HistoryController>();
  TabController tabController;

  @override
  void initState() {
    super.initState();
    historyController.init();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (tabController.index == 1) {
          tabController.animateTo(0);
          historyController.clearTicketList();
          return false;
        }
        historyController.clearTicketList();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Histórico de bilhetes'),
          centerTitle: true,
        ),
        body: TabBarView(
          controller: tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _getBody(),
              ),
            ),
            ListTicketComponent(),
          ],
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
      children.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          historyController.getMounthName(i),
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
      children.addAll(historyController.raffleDates
          .sublist(startSubList, startSubList + 2)
          .map<Widget>(
            (date) => ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              title: Text(DateFormat('dd/MM/yyyy').format(date)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                historyController.getHistoryTickets(date);
                tabController.animateTo(1);
              },
            ),
          )
          .toList());
      startSubList += 2;
    }

    return children;
  }
}
