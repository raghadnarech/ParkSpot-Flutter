import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/provider/WalletProvider.dart';
import 'package:park_spot/view/Auth/login.dart';
import 'package:park_spot/view/Car/myvehicle_page.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:park_spot/view/HistoryBooking/history_booking.dart';
import 'package:park_spot/view/Transactions/walletpage.dart';
import 'package:park_spot/widget/list_tile_drarwer.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    walletProvider = Provider.of<WalletProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: kBaseColor,
      width: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings,
                            size: 20,
                            color: kPrimaryColor,
                          ),
                          SizedBox(width: width * 0.03),
                          Text(
                            "Setting",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${authProvider.user.name}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  Text("My Profile",
                                      style: TextStyle(
                                          color: kBaseSecandryColor,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
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
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: InkWell(
                                onTap: () async {
                                  transactionProvider.getMyTransaction();
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: WalletPage(),
                                        isIos: false,
                                        duration: Duration(milliseconds: 300),
                                      ));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Icon(
                                              Icons
                                                  .account_balance_wallet_outlined,
                                              size: 30,
                                              color: kBaseColor,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Wallat",
                                                style: TextStyle(
                                                  color: kBaseColor,
                                                ),
                                              ),
                                              Text(
                                                "Quick Payment",
                                                style: TextStyle(
                                                    color: kBaseColor,
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.05,
                                      child: Row(
                                        children: [
                                          Text(
                                              "\$${walletProvider.wallet.amount}",
                                              style:
                                                  TextStyle(color: kBaseColor)),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                            color: kBaseColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: Container(
                            decoration: BoxDecoration(
                                color: kBaseColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            height: height * 0.6005,
                            width: double.infinity,
                            child: ListView(children: [
                              ListTileDrawer(
                                title: "My vehicle",
                                subtitle: "Add vehicle",
                                icon: Icons.directions_car_filled_outlined,
                                navigator: MyVehiclePage(),
                              ),
                              ListTileDrawer(
                                title: "Favorite Parking",
                                subtitle: "Pre Saved Parking",
                                icon: Icons.favorite,
                                navigator: MyVehiclePage(),
                              ),
                              ListTileDrawer(
                                title: "History Booking",
                                subtitle: "Show Your History",
                                icon: Icons.history,
                                navigator: HistoryBooking(),
                              ),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                leading: Icon(Icons.remove_red_eye_outlined,
                                    color: kPrimaryColor, size: 30),
                                title: Text("Dark Theme"),
                                trailing: Switch(
                                  value: isChecked,
                                  onChanged: (bool value) {
                                    isChecked = !value;
                                  },
                                ),
                              ),
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                leading: Icon(Icons.logout,
                                    color: kPrimaryColor, size: 30),
                                title: Text("Logout"),
                                onTap: () async {
                                  authProvider.removeUser();
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: LoginPage(),
                                        isIos: false,
                                        duration: Duration(milliseconds: 300),
                                      ));
                                },
                              ),
                            ]),
                          ),
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
