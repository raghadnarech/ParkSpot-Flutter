import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:park_spot/const/constants.dart';
import 'package:park_spot/model/tansaction.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/provider/BookProvider.dart';
import 'package:park_spot/provider/MapProvider.dart';
import 'package:park_spot/provider/TransactionProvider.dart';
import 'package:park_spot/provider/CarProvider.dart';
import 'package:park_spot/view/Car/myvehicle_page.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:park_spot/view/Transactions/Payments.dart';
import 'package:park_spot/view/Transactions/ToWalletPage.dart';
import 'package:park_spot/view/HistoryBooking/history_booking.dart';
import 'package:park_spot/widget/list_tile_drarwer.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    carProvider = Provider.of<CarProvider>(context);
    bookProvider = Provider.of<BookProvider>(context);
    transactionProvider = Provider.of<TransactionProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(indicatorColor: kPrimaryColor, tabs: [
              Tab(
                icon: Icon(Icons.arrow_downward),
                text: "To Wallet",
              ),
              Tab(
                icon: Icon(Icons.arrow_upward),
                text: "Payments",
              ),
            ]),
            title: Text("Wallet"),
            centerTitle: true,
            backgroundColor: kPrimaryColor,
          ),
          body: TabBarView(children: [ToWalletPage(), Payment()])),
    );
  }
}
