import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:park_spot/const/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_spot/provider/UserProvider.dart';
import 'package:park_spot/view/splash.dart';
import 'package:park_spot/view/userpage/parking_timer.dart';
import 'package:park_spot/view/userpage/select_car.dart';
import 'package:provider/provider.dart';

class Parking_Confirm extends StatefulWidget {
  String? parkname;
  String? parktype;
  Parking_Confirm({this.parkname, this.parktype, super.key});

  @override
  State<Parking_Confirm> createState() => _Parking_ConfirmState();
}

class _Parking_ConfirmState extends State<Parking_Confirm> {
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    int def = userProvider!.defaultcar;
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
            child: Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Vehiacle",
                          style: TextStyle(
                            color: kBaseSecandryColor,
                            fontSize: 18,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.leftToRight,
                                  child: SelectCar(),
                                  isIos: false,
                                  duration: Duration(milliseconds: 300),
                                ));
                          },
                          child: Text(
                            "Change",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${userProvider!.CarList[userProvider!.defaultcar].Type}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${userProvider!.CarList[userProvider!.defaultcar].Country}" +
                                      " | " +
                                      "${userProvider!.CarList[userProvider!.defaultcar].NumCar}",
                                  style: TextStyle(
                                      fontSize: 18, color: kBaseSecandryColor),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "image/carlogo/car.png",
                                  width: 120,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
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
                              isSelected = 1;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: isSelected == 1
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
                                          color: isSelected == 1
                                              ? kBaseColor
                                              : kBaseThirdyColor),
                                    ),
                                    Text(
                                      "500 sp",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: isSelected == 1
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
                              isSelected = 2;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kPrimaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                  color: isSelected == 2
                                      ? kPrimaryColor
                                      : kBaseColor),
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
                                          color: isSelected == 2
                                              ? kBaseColor
                                              : kBaseThirdyColor),
                                    ),
                                    Text(
                                      "1000 sp",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: isSelected == 2
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
                              isSelected = 3;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: isSelected == 3
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
                                          color: isSelected == 3
                                              ? kBaseColor
                                              : kBaseThirdyColor),
                                    ),
                                    Text(
                                      "1500 sp",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: isSelected == 3
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
                              isSelected = 4;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kPrimaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                  color: isSelected == 4
                                      ? kPrimaryColor
                                      : kBaseColor),
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
                                          color: isSelected == 4
                                              ? kBaseColor
                                              : kBaseThirdyColor),
                                    ),
                                    Text(
                                      "2000 sp",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: isSelected == 4
                                              ? kBaseColor
                                              : kBaseSecandryColor),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "image/wallet.png",
                                      width: 35,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Wallet",
                                      style: TextStyle(
                                          color: kBaseColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "10000 sp",
                                      style: TextStyle(
                                          color: kBaseColor, fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ))),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            if (isSelected != 0) {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: Parking_Timer(
                                      index: userProvider!.defaultcar,
                                      time: isSelected,
                                      parkingName: widget.parkname,
                                      parkingType: widget.parktype,
                                    ),
                                    isIos: false,
                                    duration: Duration(milliseconds: 300),
                                  ));
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
                          child: Text("Pay"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor),
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
