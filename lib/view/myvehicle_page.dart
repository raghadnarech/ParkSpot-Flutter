import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/provider/AuthProvider.dart';
import 'package:park_spot/provider/UserProvider.dart';
import 'package:park_spot/view/Auth/register_car.dart';
import 'package:park_spot/view/home.dart';
import 'package:park_spot/view/splash.dart';
import 'package:park_spot/widget/list_tile_drarwer.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyVehiclePage extends StatelessWidget {
  const MyVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBaseColor,
        foregroundColor: kBaseThirdyColor,
        elevation: 0,
      ),
      body: userProvider!.isLoading
          ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
          : Column(
              children: [
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          height: height * 0.4,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              height: height * 0.2,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: Register_Car(),
                                        isIos: false,
                                        duration: Duration(milliseconds: 300),
                                      ));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: kBaseColor,
                                      size: 35,
                                    ),
                                    Text(
                                      "ADD NEW VEHICLE",
                                      style: TextStyle(
                                          color: kBaseColor, fontSize: 25),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: kBaseColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              height: height * 0.62,
                              width: double.infinity,
                              child: ListView.builder(
                                  itemCount: userProvider!.CarList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Slidable(
                                      endActionPane: ActionPane(
                                        motion: StretchMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) async {
                                              userProvider!.getallCar_user();
                                              if (userProvider!
                                                      .CarList.length !=
                                                  1) {
                                                userProvider!.delete_car(
                                                    userProvider!
                                                        .CarList[index].Country,
                                                    userProvider!
                                                        .CarList[index].NumCar
                                                        .toString());
                                                userProvider!.getallCar_user();
                                              } else {
                                                Flushbar(
                                                  title: 'Action Denied',
                                                  message:
                                                      'You must own at least one car',
                                                  duration:
                                                      Duration(seconds: 3),
                                                ).show(context);
                                              }
                                            },
                                            backgroundColor: Colors.red,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                          )
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Text(
                                            "${userProvider!.CarList[index].Type}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                        subtitle: Text(
                                            "${userProvider!.CarList[index].Country} | ${userProvider!.CarList[index].NumCar}"),
                                        trailing: Image.asset(
                                          "image/carlogo/car.png",
                                          fit: BoxFit.fitWidth,
                                          width: width * 0.3,
                                        ),
                                      ),
                                    );
                                  })))
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
