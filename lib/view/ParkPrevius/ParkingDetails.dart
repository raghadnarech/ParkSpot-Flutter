import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:park_spot/const/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_spot/provider/BookProvider.dart';
import 'package:park_spot/provider/CarProvider.dart';
import 'package:park_spot/provider/WalletProvider.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:park_spot/view/ParkPrevius/Parking_Timer.dart';
import 'package:park_spot/view/Car/select_car.dart';
import 'package:park_spot/widget/Cards/CardCarPreview.dart';
import 'package:park_spot/widget/Cards/SelectVehiacleCard.dart';
import 'package:park_spot/widget/Icon/WalletIcon.dart';
import 'package:provider/provider.dart';

class Parking_Details extends StatefulWidget {
  String? parkname;
  String? parktype;
  int? idpark;
  Parking_Details({this.parkname, this.parktype, this.idpark, super.key});

  @override
  State<Parking_Details> createState() => _Parking_DetailsState();
}

class _Parking_DetailsState extends State<Parking_Details> {
  int isSelectedMain = 0;

  @override
  Widget build(BuildContext context) {
    bookProvider = Provider.of<BookProvider>(context);
    carProvider = Provider.of<CarProvider>(context);
    walletProvider = Provider.of<WalletProvider>(context);
    int def = carProvider.defaultcar;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Parking Details"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.parkname}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      Text("${widget.parktype}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 10,
                      blurRadius: 5,
                      offset: Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: kBaseColor),
              height: MediaQuery.of(context).size.height * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectVehiacleCard(),
                    CardCarPreview(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select hours",
                          style: TextStyle(
                            color: kBaseSecandryColor,
                            fontSize: 18,
                          ),
                        ),
                        Icon(
                          Icons.watch_later_outlined,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelectedMain = 1;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: isSelectedMain == 1
                                    ? kPrimaryColor
                                    : kBaseColor,
                                border:
                                    Border.all(color: kPrimaryColor, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "1 Hours",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: isSelectedMain == 1
                                              ? kBaseColor
                                              : kBaseThirdyColor),
                                    ),
                                    Text(
                                      "500 sp",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: isSelectedMain == 1
                                              ? kBaseColor
                                              : kBaseSecandryColor),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelectedMain = 2;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: isSelectedMain == 2
                                    ? kPrimaryColor
                                    : kBaseColor,
                                border:
                                    Border.all(color: kPrimaryColor, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "2 Hours",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: isSelectedMain == 2
                                              ? kBaseColor
                                              : kBaseThirdyColor),
                                    ),
                                    Text(
                                      "1000 sp",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: isSelectedMain == 2
                                              ? kBaseColor
                                              : kBaseSecandryColor),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelectedMain = 3;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: isSelectedMain == 3
                                    ? kPrimaryColor
                                    : kBaseColor,
                                border:
                                    Border.all(color: kPrimaryColor, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "3 Hours",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: isSelectedMain == 3
                                              ? kBaseColor
                                              : kBaseThirdyColor),
                                    ),
                                    Text(
                                      "1500 sp",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: isSelectedMain == 3
                                              ? kBaseColor
                                              : kBaseSecandryColor),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelectedMain = 4;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: isSelectedMain == 4
                                    ? kPrimaryColor
                                    : kBaseColor,
                                border:
                                    Border.all(color: kPrimaryColor, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "4 Hours",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: isSelectedMain == 4
                                              ? kBaseColor
                                              : kBaseThirdyColor),
                                    ),
                                    Text(
                                      "2000 sp",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: isSelectedMain == 4
                                              ? kBaseColor
                                              : kBaseSecandryColor),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    WalletIcons(),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () async {
                            String text;
                            if (isSelectedMain != 0) {
                              text = await bookProvider.createBook(
                                  isSelectedMain,
                                  carProvider
                                      .CarList[carProvider.defaultcar].Country,
                                  carProvider
                                      .CarList[carProvider.defaultcar].NumCar,
                                  1);
                              if (text != '') {
                                // ignore: use_build_context_synchronously
                                Flushbar(
                                  title: 'Error',
                                  message: '$text',
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 3),
                                ).show(context);
                              } else {
                                // await userProvider!.getamount();

                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: Parking_Timer(),
                                      isIos: false,
                                      duration: Duration(milliseconds: 300),
                                    ));
                              }
                            } else {
                              Flushbar(
                                title: 'Please select hours to park',
                                message:
                                    'You must choose at least an hour to book',
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                              ).show(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor),
                          child: Text("Pay"),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
