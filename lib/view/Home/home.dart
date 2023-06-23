import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/main.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/provider/BookProvider.dart';
import 'package:park_spot/provider/MapProvider.dart';
import 'package:park_spot/provider/TransactionProvider.dart';
import 'package:park_spot/provider/CarProvider.dart';
import 'package:park_spot/view/Auth/login.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:park_spot/view/HistoryBooking/history_booking.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_spot/view/ParkPrevius/ParkMap.dart';
import 'package:park_spot/view/ParkingNow/parking_now.dart';
import 'package:park_spot/view/Car/myvehicle_page.dart';
import 'package:park_spot/view/ParkPrevius/Parking_Timer.dart';
import 'package:park_spot/view/ParkPrevius/ParkingHome.dart';
import 'package:park_spot/view/Transactions/walletpage.dart';
import 'package:park_spot/widget/CutomDrawer.dart';
import 'package:park_spot/widget/button_grid_home.dart';
import 'package:park_spot/widget/list_tile_drarwer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await authProvider.getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    mapProvider = Provider.of<MapProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);
    carProvider = Provider.of<CarProvider>(context);
    bookProvider = Provider.of<BookProvider>(context);
    transactionProvider = Provider.of<TransactionProvider>(context);
    FirebaseMessaging f = FirebaseMessaging.instance;

    return Scaffold(
      backgroundColor: kBaseColor,
      appBar: AppBar(
          centerTitle: true,
          title: Text("parking spot"),
          backgroundColor: kPrimaryColor),
      drawer: CustomDrawer(),
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
                        "Welcome ${authProvider.user.name} ",
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
            child: GridView.count(
              crossAxisSpacing: 25,
              mainAxisSpacing: 25,
              padding: EdgeInsets.all(30),
              crossAxisCount: 2,
              children: [
                ButtonGridHome(
                  image: "image/spaces.png",
                  title: "Park Now",
                  onTap: () async {
                    carProvider.getallCar_user();
                    mapProvider.getallZone();
                    Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: ParkingNow(),
                          isIos: false,
                          duration: Duration(milliseconds: 300),
                        ));
                  },
                ),
                ButtonGridHome(
                    image: "image/spaces1.png",
                    title: "Park On Street",
                    onTap: () async {
                      if (await bookProvider.getbook()) {
                        Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: Parking_Timer(),
                              isIos: false,
                              duration: Duration(milliseconds: 300),
                            ));
                      } else {
                        carProvider.getallCar_user();
                        mapProvider.getallZone();
                        Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: ParkingHome(),
                              isIos: false,
                              duration: Duration(milliseconds: 300),
                            ));
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
