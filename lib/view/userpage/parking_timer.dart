import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/view/splash.dart';
import 'package:park_spot/widget/rowfromparkindetail.dart';

class Parking_Timer extends StatelessWidget {
  int? time;
  String? parkingName;
  String? parkingType;
  int? index;

  Parking_Timer({this.index, this.parkingName, this.time, this.parkingType});
  final _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Parking Timer"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: CountDownProgressIndicator(
                      timeTextStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 4),
                      labelTextStyle:
                          TextStyle(fontSize: 10, color: kBaseSecandryColor),
                      strokeWidth: 15,
                      controller: _controller,
                      valueColor: kPrimaryColor,
                      backgroundColor: kBaseSecandryColor,
                      initialPosition: 0,
                      duration: time! * 3600,
                      timeFormatter: (seconds) {
                        return Duration(seconds: seconds)
                            .toString()
                            .split('.')[0]
                            .padLeft(8, '0');
                      },
                      onComplete: () => null,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor, width: 1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RowDetailsParkingTimer(
                            title: "Parking Area",
                            text: "$parkingName",
                          ),
                          RowDetailsParkingTimer(
                            title: "Parking Type",
                            text: "$parkingType",
                          ),
                          RowDetailsParkingTimer(
                            title: "Vehicle",
                            text: "${userProvider!.CarList[userProvider!.defaultcar].Type}" +
                                "  ${userProvider!.CarList[userProvider!.defaultcar].NumCar}",
                          ),
                          RowDetailsParkingTimer(
                            title: "Parking Spot",
                            text: "from DB",
                          ),
                          RowDetailsParkingTimer(
                            title: "Date",
                            text: "From DB",
                          ),
                          RowDetailsParkingTimer(
                            title: "Duration",
                            text: "$time",
                          ),
                          RowDetailsParkingTimer(
                            title: "Hours",
                            text: "From DB",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor),
                            child: Text("Extend Parking Time"),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
