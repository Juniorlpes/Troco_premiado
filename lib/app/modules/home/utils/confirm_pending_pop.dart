import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/app/modules/home/home_controller.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';

Future<void> requestConfirmPendingPop(
    BuildContext context, TicketRaffle ticket) async {
  final controller = Modular.get<HomeController>();
  return await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      title: Text(
        'O que deseja fazer com o bilhete de ${ticket.clientName}?',
        textAlign: TextAlign.center,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RaisedButton(
            onPressed: () {
              controller.removeTicketFromPendingList(ticket);
              Modular.to.pop();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.red,
            child: Text(
              'Excluir bilhete',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              var oldValue = ticket.ticketValue;
              var newValue = await _confirmValue(_, ticket.ticketValue);
              if (newValue == null) return;
              controller.saveTicketAsReal(
                  ticket..ticketValue = newValue, oldValue);
              Modular.to.pop();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.blue[700],
            child: Text(
              'Confirmar bilhete',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<double> _confirmValue(BuildContext context, double initialValue) async {
  final _formKey = GlobalKey<FormState>();
  final valueController = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
    decimalSeparator: ".",
    initialValue: initialValue,
  );
  return await showDialog<double>(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      title: Text(
        'Confirme o valor',
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          ),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
          keyboardType: TextInputType.numberWithOptions(),
          controller: valueController,
          validator: (s) {
            final stringValue = s.replaceAll('R\$', '');
            final douleValue = double.parse(stringValue);
            if (douleValue > 4.99 || douleValue < 0.01) {
              return 'Por favor, valores devem ser entre 0,01 e 4,99';
            } else {
              return null;
            }
          },
        ),
      ),
      actions: [
        RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate())
              Modular.to.pop(
                  double.parse(valueController.text.replaceAll('R\$', '')));
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: Colors.blue[700],
          child: Text(
            'Confirmar bilhete',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
