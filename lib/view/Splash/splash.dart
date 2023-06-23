import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:park_spot/main.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/provider/BookProvider.dart';
import 'package:park_spot/provider/MapProvider.dart';
import 'package:park_spot/provider/TransactionProvider.dart';
import 'package:park_spot/provider/CarProvider.dart';
import 'package:park_spot/provider/WalletProvider.dart';

import 'package:park_spot/view/Auth/login.dart';
import 'package:park_spot/view/Home/home.dart';
import 'package:park_spot/view/onboarding/onboarding.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  final bool showLogin;
  final bool isLogging;
  Splash({required this.showLogin, required this.isLogging});
  @override
  State<Splash> createState() => _SplashState();
}

MapProvider mapProvider = MapProvider();
AuthProvider authProvider = AuthProvider();
CarProvider carProvider = CarProvider();
BookProvider bookProvider = BookProvider();
TransactionProvider transactionProvider = TransactionProvider();
WalletProvider walletProvider = WalletProvider();

class _SplashState extends State<Splash> {
  @override
  void initState() {
    _navigatetohome();
    super.initState();
  }

  Future<Widget> routePage() async {
    if (widget.isLogging) {
      walletProvider.getamount();
      transactionProvider.getTypeCost();
      authProvider.getUser();
      return HomePage();
    } else {
      if (widget.showLogin) {
        return LoginPage();
      } else {
        return OnBoarding();
      }
    }
  }

  _navigatetohome() async {
    await Future.delayed(
        Duration(seconds: 7),
        () async => {
              mapProvider.checkPermissionAndGetLocation(),
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: await routePage(),
                    isIos: false,
                    duration: Duration(milliseconds: 300),
                  ))
            });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mapProvider = Provider.of<MapProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);
    carProvider = Provider.of<CarProvider>(context);
    walletProvider = Provider.of<WalletProvider>(context);
    transactionProvider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      body: SizedBox(
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.width * 0.6,
                      child: Image.asset("image/Logo.png")),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('Parking Spot',
                          textStyle: TextStyle(
                              color: Color(0xff11c675),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Robota"))
                    ],
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
