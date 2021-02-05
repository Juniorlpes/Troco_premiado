import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';

class HistoryCard extends StatelessWidget {
  final TicketRaffle ticket;

  const HistoryCard(this.ticket);

  @override
  Widget build(BuildContext context) {
    final phoneController = MaskedTextController(
        text: ticket.clientPhoneNumber, mask: '(00) 0 0000-0000');
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Container(
            alignment: Alignment.center,
            child: Text(
              '${ticket.formattedRaffleNumber} - R\$${(ticket.ticketValue * 1000).toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Nome: ${ticket.clientName}',
            style: TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 6),
          Text(
            'Telefone: ${phoneController.text}',
            style: TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 6),
          Text(
            'Criado dia: ${DateFormat('dd/MM/yyyy').format(ticket.createdDate)}',
            style: TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 6),
          Text(
            'Sorteio dia: ${DateFormat('dd/MM/yyyy').format(ticket.raffleDate)}',
            style: TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
