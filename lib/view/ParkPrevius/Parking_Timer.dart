import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/provider/BookProvider.dart';
import 'package:park_spot/provider/CarProvider.dart';
import 'package:park_spot/provider/WalletProvider.dart';
import 'package:park_spot/view/Home/home.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:park_spot/widget/rowfromparkindetail.dart';
import 'package:provider/provider.dart';

class Parking_Timer extends StatefulWidget {
  @override
  State<Parking_Timer> createState() => _Parking_TimerState();
}

class _Parking_TimerState extends State<Parking_Timer> {
  final _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    walletProvider = Provider.of<WalletProvider>(context);
    int hourselect = 1;
    List<int> hours = [1, 2, 3, 4];
    bookProvider = Provider.of<BookProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Parking Timer"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.topToBottom,
                    child: HomePage(),
                    isIos: false,
                    duration: Duration(milliseconds: 300),
                  ));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: bookProvider.isLoadingparking!
          ? Center(
              child: CircularProgressIndicator(
              color: kPrimaryColor,
            ))
          : SingleChildScrollView(
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
                            labelTextStyle: TextStyle(
                                fontSize: 10, color: kBaseSecandryColor),
                            strokeWidth: 15,
                            controller: _controller,
                            valueColor: kPrimaryColor,
                            backgroundColor: kBaseSecandryColor,
                            initialPosition: 0,
                            duration: bookProvider.book!.calctime!,
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
                              border:
                                  Border.all(color: kPrimaryColor, width: 1),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RowDetailsParkingTimer(
                                  title: "Parking Area",
                                  text: "${bookProvider.book!.zonename}",
                                ),
                                RowDetailsParkingTimer(
                                  title: "Vehicle",
                                  text: "${bookProvider.book!.country}" +
                                      "  ${bookProvider.book!.num_car}",
                                ),
                                RowDetailsParkingTimer(
                                  title: "Parking Spot",
                                  text: "${bookProvider.book!.parkspot}",
                                ),
                                RowDetailsParkingTimer(
                                  title: "Date",
                                  text: "${bookProvider.book!.date}",
                                ),
                                RowDetailsParkingTimer(
                                  title: "Duration",
                                  text: "${bookProvider.book!.hours}",
                                ),
                                RowDetailsParkingTimer(
                                  title: "Start Time:",
                                  text:
                                      "${bookProvider.book!.startTime!.substring(0, 5)}",
                                ),
                                RowDetailsParkingTimer(
                                  title: "End Time:",
                                  text:
                                      "${bookProvider.book!.endTime!.substring(0, 5)}",
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
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return StatefulBuilder(
                                            builder: (context, setState) => AlertDialog(
                                                actions: [
                                                  ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateColor
                                                                  .resolveWith(
                                                                      (states) =>
                                                                          kPrimaryColor)),
                                                      onPressed: () async {
                                                        await bookProvider
                                                            .extendParkingTime(
                                                                hourselect);

                                                        await bookProvider
                                                            .getbook();
                                                        await walletProvider
                                                            .getamount();

                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Ok"))
                                                ],
                                                content: DropdownButtonFormField(
                                                    dropdownColor: Color(0xffececec),
                                                    decoration: InputDecoration(
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                            borderSide: BorderSide(
                                                              color: Color(
                                                                  0xffececec),
                                                            )),
                                                        fillColor: Color(0xffececec),
                                                        focusColor: Color(0xffececec),
                                                        disabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                            borderSide: BorderSide(
                                                              color: Color(
                                                                  0xffececec),
                                                            )),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                            borderSide: BorderSide(
                                                              color: Color(
                                                                  0xffececec),
                                                            )),
                                                        border: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xffececec),
                                                          ),
                                                        )),
                                                    value: hourselect,
                                                    items: hours
                                                        .map((item) => DropdownMenuItem<int>(
                                                              value: item,
                                                              child: Text(item
                                                                  .toString()),
                                                            ))
                                                        .toList(),
                                                    onChanged: (int? item) => setState(() {
                                                          hourselect = item!;
                                                        })),
                                                title: Text("Choese Extend Hours: ")),
                                          );
                                        });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kPrimaryColor),
                                  child: Text("Go To Map"),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: Text("End Park"),
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text("End Park"),
                                              content: Text(
                                                  "Are you sure the reservation is over?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )),
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateColor
                                                                .resolveWith(
                                                                    (states) =>
                                                                        Colors
                                                                            .green)),
                                                    onPressed: () async {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .topToBottom,
                                                            child: HomePage(),
                                                            isIos: false,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    100),
                                                          ));
                                                      await bookProvider
                                                          .endPark();
                                                    },
                                                    child: Text("Confirm"))
                                              ],
                                            ));
                                  },
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
