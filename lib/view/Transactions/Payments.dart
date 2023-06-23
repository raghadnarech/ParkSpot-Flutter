import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/provider/BookProvider.dart';
import 'package:park_spot/provider/TransactionProvider.dart';
import 'package:park_spot/provider/CarProvider.dart';
import 'package:park_spot/provider/WalletProvider.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:provider/provider.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    walletProvider = Provider.of<WalletProvider>(context);
    bookProvider = Provider.of<BookProvider>(context);
    transactionProvider = Provider.of<TransactionProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      child: ListView.builder(
        itemCount: transactionProvider.listtransactions.length,
        itemBuilder: (context, index) => SizedBox(
          height: height * 0.1,
          child: Card(
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    Icons.money_off,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                    child: Text(
                        "${transactionProvider.listtransactions[index].cost}")),
                Expanded(
                    child: Text(
                        "${transactionProvider.listTypeCost.firstWhere((element) => element.id == transactionProvider.listtransactions[index].typepay_id).type}"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
