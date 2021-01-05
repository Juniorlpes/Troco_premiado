import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    Future<void>.delayed(Duration(milliseconds: 100)).then(
      (_) => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: screenSize.height,
              width: screenSize.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Theme.of(context).primaryColor, Colors.white],
                ),
              ),
            ),
            Container(
              width: screenSize.width,
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * 0.12),
                  Text(
                    'Log In',
                    style: GoogleFonts.dancingScript(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.1),
                  Container(
                    width: screenSize.width * 0.8,
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          height: 22,
                          child: Image.asset(
                            'assets/images/google.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        title: Text('Logar com Google'),
                        onTap: () {},
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
