import 'package:flutter/material.dart';
import 'package:troco_premiado/app/modules/home/utils/confirm_pending_pop.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';

class PendingCard extends StatelessWidget {
  final TicketRaffle ticket;

  const PendingCard({Key key, @required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => requestConfirmPendingPop(context, ticket),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ticket.clientName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text('Valor: ${ticket.ticketValue}'),
              Text('Telefone: ${ticket.clientPhoneNumber}'),
            ],
          ),
        ),
      ),
    );
  }
}
