import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/provider/BookProvider.dart';
import 'package:park_spot/provider/TransactionProvider.dart';
import 'package:park_spot/provider/CarProvider.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:provider/provider.dart';

class ToWalletPage extends StatelessWidget {
  const ToWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    carProvider = Provider.of<CarProvider>(context);
    bookProvider = Provider.of<BookProvider>(context);
    transactionProvider = Provider.of<TransactionProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Text(""),
    );
  }
}
