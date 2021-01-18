import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.count(
          crossAxisCount: 3,
          primary: false,
          scrollDirection: Axis.vertical,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: const EdgeInsets.all(10),
          children: [
            Card(
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.monetization_on,
                      size: 28,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Novo Sorteio',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.receipt,
                      size: 28,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Histórico',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
