import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/app/modules/home/home_controller.dart';
import 'package:troco_premiado/app/modules/home/pages/ticket_page.dart';
import 'package:troco_premiado/shared/components/general_loading_pop.dart';
import 'package:toast/toast.dart';

class CreateRafflePage extends StatefulWidget {
  @override
  _RafflePageState createState() => _RafflePageState();
}

class _RafflePageState extends State<CreateRafflePage> {
  final _formKey = GlobalKey<FormState>();
  final controller = Modular.get<HomeController>();
  final valueController =
      MoneyMaskedTextController(leftSymbol: 'R\$ ', decimalSeparator: ".");
  final nameController = TextEditingController();
  final phoneController = MaskedTextController(mask: '(00) 0 0000-0000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de sorteio'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Valor do Troco',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                getValueFormField(),
                const SizedBox(height: 6),
                Text(
                  'Nome do cliente',
                  style: TextStyle(
                    fontSize: 17,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  validator: (s) {
                    if (s.trim().isEmpty) {
                      return 'Campo obrigatório';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 6),
                Text(
                  'Telefone do cliente',
                  style: TextStyle(
                    fontSize: 17,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: (s) {
                    if (s.trim().isEmpty) {
                      return 'Campo obrigatório';
                    } else {
                      final realNumber = s
                          .trim()
                          .replaceAll(' ', '')
                          .replaceAll('(', '')
                          .replaceAll(')', '')
                          .replaceAll('-', '');
                      if (realNumber.length != 11) {
                        return 'Campo inválido';
                      }
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 30),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.green,
                    child: Text(
                      'Gerar Ticket',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        showGeneralLoadingPop(context);
                        final realPhone = phoneController.text
                            .trim()
                            .replaceAll(' ', '')
                            .replaceAll('(', '')
                            .replaceAll(')', '')
                            .replaceAll('-', '');
                        final realValue = double.parse(
                            valueController.text.replaceAll('R\$', ''));

                        final ticket = await controller.createTicketRaffle(
                          nameController.text,
                          realPhone,
                          realValue,
                        );
                        Modular.to.pop();
                        if (ticket == null) {
                          Toast.show("Erro ao gerar Ticket", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        } else {
                          Modular.to.pushReplacement(MaterialPageRoute(
                              builder: (_) => TicketPage(ticket: ticket)));
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getValueFormField() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
      // onFieldSubmitted: (s) => _formKey.currentState.validate(),
    );
  }
}
