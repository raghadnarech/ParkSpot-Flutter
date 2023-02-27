import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/main.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/provider/MapProvider.dart';
import 'package:park_spot/provider/UserProvider.dart';
import 'package:park_spot/view/Auth/login.dart';
import 'package:park_spot/view/splash.dart';
import 'package:park_spot/view/userpage/history_booking.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_spot/view/userpage/park_now.dart';
import 'package:park_spot/view/userpage/parking_now.dart';
import 'package:park_spot/view/myvehicle_page.dart';
import 'package:park_spot/view/userpage/parknow_home.dart';
import 'package:park_spot/widget/button_grid_home.dart';
import 'package:park_spot/widget/list_tile_drarwer.dart';
import 'package:provider/provider.dart';

MapProvider? mapProvider;

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    mapProvider = Provider.of<MapProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    bool isChecked = false;

    return Scaffold(
      backgroundColor: kBaseColor,
      appBar: AppBar(
          centerTitle: true,
          title: Text("parking spot"),
          backgroundColor: kPrimaryColor),
      drawer: Drawer(
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
                                    Text("${userProvider!.user.name}",
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
                                              "\$${userProvider!.wallet!.amount}",
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
                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: LoginPage(),
                                          isIos: false,
                                          duration: Duration(milliseconds: 300),
                                        ));
                                    userProvider!.removeUser();
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
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome ${userProvider!.user.name} ",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Image.asset(
                    "image/Logo.png",
                    width: width * 0.25,
                  ),
                ],
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(height: height * 0.2, autoPlay: true),
            items: [
              "image/board1.png",
              "image/board1.png",
              "image/board1.png",
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: kBaseSecandryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "$i",
                        fit: BoxFit.cover,
                      ));
                },
              );
            }).toList(),
          ),
          Expanded(
            child: Container(
              child: GridView.count(
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
                padding: EdgeInsets.all(30),
                crossAxisCount: 2,
                children: [
                  ButtonGridHome(
                    image: "image/spaces.png",
                    title: "Park Now",
                    navigator: ParkingNow(),
                  ),
                  ButtonGridHome(
                    image: "image/spaces1.png",
                    title: "Park On Street",
                    navigator: ParkingHome(),
                  ),
                  ButtonGridHome(
                    image: "image/spaces.png",
                    title: "Park On Street",
                    navigator: HomePage(),
                  ),
                  ButtonGridHome(
                    image: "image/spaces.png",
                    title: "Park On Street",
                    navigator: HomePage(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
