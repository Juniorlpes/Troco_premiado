import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:troco_premiado/app/modules/home/pages/print_page.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';

class TicketPage extends StatelessWidget {
  final TicketRaffle ticket;

  const TicketPage({Key key, this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final phoneController = MaskedTextController(
        text: ticket.clientPhoneNumber, mask: '(00) 0 0000-0000');
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket do prêmio'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ticket.formattedRaffleNumber,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              const SizedBox(height: 15),
              QrImage(
                data: ticket.formattedRaffleNumber,
                version: QrVersions.auto,
                size: 170.0,
              ),
              const SizedBox(height: 15),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nome: ${ticket.clientName}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Telefone: ${phoneController.text}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Prêmio final: ${(ticket.ticketValue * 1000).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Criado em: ${DateFormat('dd/MM/yyyy').format(ticket.createdDate)}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blue[600],
                  child: Text(
                    'Imprimir Ticket',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () async {
                    Modular.to.push(MaterialPageRoute(
                        builder: (_) => PrintPage(ticket: ticket)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
