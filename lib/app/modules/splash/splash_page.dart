import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';
import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: Brightness.dark,
    // ));

    disposer = autorun((_) async {
      //await Position().start();
      //Acho q o position sera necessario ao pegar company

      //delay para tentar dar tempo o Hive carregar e o Position.
      await Future<void>.delayed(Duration(milliseconds: 400));
      await Firebase.initializeApp();

      if (await controller.getCurrentAccountSuccessFully()) {
        var account = controller.prevAccount;
        Modular.to.pushReplacementNamed('/home', arguments: account);
      } else if (await controller.logInSilentilySuccessFully()) {
        var account = controller.prevAccount;
        Modular.to.pushReplacementNamed('/home', arguments: account);
      } else {
        Modular.to.pushReplacementNamed('/login');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    disposer();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        //backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //App Icon
            Container(
              height: 200,
              width: screenSize.width,
              child: Lottie.asset('assets/images/coin_loading.json'),
            ),
            const SizedBox(height: 20),
            Text(
              'Aguarde um momento...',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Container(
              width: screenSize.width * 0.75,
              child: LinearProgressIndicator(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
