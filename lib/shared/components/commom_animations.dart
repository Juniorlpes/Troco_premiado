import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SimpleLoadingAnimation extends StatelessWidget {
  final double height;
  final bool isWhite;

  SimpleLoadingAnimation({this.height = 140, this.isWhite = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        child: Lottie.asset(
          isWhite
              ? 'assets/images/circle-loading-white.json'
              : 'assets/images/circle-loading.json',
          fit: BoxFit.cover,
          repeat: true,
        ),
      ),
    );
  }
}
