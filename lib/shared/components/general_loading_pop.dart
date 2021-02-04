import 'package:flutter/material.dart';
import 'package:troco_premiado/shared/components/commom_animations.dart';

Future<void> showGeneralLoadingPop(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => SimpleLoadingAnimation(isWhite: true),
  );
}
