import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/provider/BookProvider.dart';
import 'package:park_spot/provider/MapProvider.dart';
import 'package:park_spot/provider/TransactionProvider.dart';
import 'package:park_spot/provider/CarProvider.dart';
import 'package:park_spot/provider/WalletProvider.dart';
import 'package:park_spot/view/Auth/register.dart';
import 'package:park_spot/view/Home/home.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final showLogin = prefs.getBool('showlogin') ?? false;
  final isloging = prefs.getBool('isLogged') ?? false;
  print(showLogin);
  print(isloging);
  runApp(MyApp(
    showLogin: showLogin,
    isLogging: isloging,
  ));
}

late SharedPreferences prefs;

class MyApp extends StatelessWidget {
  final bool showLogin;
  final bool isLogging;
  MyApp({required this.showLogin, required this.isLogging});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: ((context) => AuthProvider())),
        ChangeNotifierProvider<MapProvider>(
            create: ((context) => MapProvider())),
        ChangeNotifierProvider<CarProvider>(
          create: ((context) => CarProvider()),
        ),
        ChangeNotifierProvider<BookProvider>(
          create: ((context) => BookProvider()),
        ),
        ChangeNotifierProvider<TransactionProvider>(
          create: ((context) => TransactionProvider()),
        ),
        ChangeNotifierProvider<WalletProvider>(
          create: ((context) => WalletProvider()),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'Poppins',
            // useMaterial3: true,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: kPrimaryColor,
              selectionColor: kSecandryColor,
              selectionHandleColor: kPrimaryColor,
            ),
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: kPrimaryColor)),
        debugShowCheckedModeBanner: false,
        home: Splash(showLogin: showLogin, isLogging: isLogging),
      ),
    );
  }
}
