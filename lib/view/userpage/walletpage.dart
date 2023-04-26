import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:park_spot/const/constants.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/provider/BookProvider.dart';
import 'package:park_spot/provider/MapProvider.dart';
import 'package:park_spot/provider/UserProvider.dart';
import 'package:park_spot/view/home.dart';
import 'package:park_spot/view/myvehicle_page.dart';
import 'package:park_spot/view/splash.dart';
import 'package:park_spot/view/userpage/history_booking.dart';
import 'package:park_spot/widget/list_tile_drarwer.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    bookProvider = Provider.of<BookProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                  height: height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Wallet",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Text("All Transaction here",
                          style: TextStyle(
                              color: kBaseSecandryColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  )),
            ),
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            height: height * 0.2,
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "To Wallet",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            VerticalDivider(),
                                            Icon(Icons.arrow_downward,
                                                color: Colors.white)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                VerticalDivider(),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Payments",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            VerticalDivider(),
                                            Icon(Icons.arrow_upward,
                                                color: Colors.white)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 70),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: kBaseColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  height: height * 0.6,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) =>
                                        Text("data"),
                                  ))),
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
