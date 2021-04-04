import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:troco_premiado/app/modules/home/pages/ticket_page.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';

class HistoryCard extends StatelessWidget {
  final TicketRaffle ticket;

  const HistoryCard(this.ticket);

  @override
  Widget build(BuildContext context) {
    final phoneController = MaskedTextController(
        text: ticket.clientPhoneNumber, mask: '(00) 0 0000-0000');
    return Card(
      child: InkWell(
        onTap: () {
          Modular.to.push(
              MaterialPageRoute(builder: (_) => TicketPage(ticket: ticket)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  '${ticket.clientName}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Número: ${ticket.formattedRaffleNumber}',
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 5),
              Text(
                'Telefone: ${phoneController.text}',
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 5),
              Text(
                'Valor: R\$${ticket.ticketValue}',
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 5),
              Text(
                'Criado dia: ${DateFormat('dd/MM/yyyy').format(ticket.createdDate)}',
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
