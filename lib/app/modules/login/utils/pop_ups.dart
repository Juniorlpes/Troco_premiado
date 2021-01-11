import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> getLogInErrorPop(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.sentiment_very_dissatisfied,
            size: 40,
            color: Colors.red,
          ),
          const SizedBox(height: 15),
          Text(
            'Algo errado ocorreu. \nPor favor, tente em instantes ou entre em contato com o desenvolvedor',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Modular.to.pop(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
