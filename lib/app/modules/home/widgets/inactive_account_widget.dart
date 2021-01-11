import 'package:flutter/material.dart';

class InactiveAccountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      color: Colors.red[400],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie.asset(
          //   'assets/images/astronaut_wait.json',
          //   height: 200,
          // ),
          Icon(Icons.account_circle, color: Colors.white, size: 100),
          const SizedBox(height: 20),
          Text(
            'Sua conta ainda não está ativa :(\nAguarde a ativação ou entre em contato com o desenvolvedor',
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
