import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/provider/MapProvider.dart';
import 'package:park_spot/view/ParkPrevius/ParkingDetails.dart';
import 'package:provider/provider.dart';

class ParkingTable extends StatefulWidget {
  const ParkingTable({Key? key}) : super(key: key);

  @override
  State<ParkingTable> createState() => _ParkingTableState();
}

class _ParkingTableState extends State<ParkingTable> {
  Widget cardButtons(IconData iconData, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(5),
          minimumSize: Size.zero,
        ),
        child: Row(
          children: [
            Icon(iconData, size: 16),
            const SizedBox(width: 2),
            Text(label)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: const Text('Parking Table'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: mapProvider.listZoneAndDirection!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: height * 0.2,
                    child: Card(
                      elevation: 10,
                      color: kBaseColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: AutoSizeText("Park Area")),
                                        Expanded(
                                            child: AutoSizeText(
                                                "${mapProvider.listZoneAndDirection![index].zone!.Location}")),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: AutoSizeText("Park Type")),
                                        Expanded(
                                            child: AutoSizeText(
                                                "${mapProvider.listZoneAndDirection![index].zone!.type}")),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.transparent,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: AutoSizeText("Distance")),
                                        Expanded(
                                          child: AutoSizeText(
                                              "${(mapProvider.listZoneAndDirection![index].direction!.distance!).toStringAsFixed(2)} km"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: AutoSizeText("Duration")),
                                        Expanded(
                                          child: AutoSizeText(
                                              "${(mapProvider.listZoneAndDirection![index].direction!.duration!).toStringAsFixed(0)} min"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.transparent,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => kPrimaryColor)),
                                      child: AutoSizeText(
                                        "Park Here",
                                        style: TextStyle(
                                            color: kBaseColor, fontSize: 18),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              child: Parking_Details(
                                                  idpark: mapProvider
                                                      .listZoneAndDirection![
                                                          index]
                                                      .zone!
                                                      .id,
                                                  parkname: mapProvider
                                                      .listZoneAndDirection![
                                                          index]
                                                      .zone!
                                                      .Location,
                                                  parktype: mapProvider
                                                      .listZoneAndDirection![
                                                          index]
                                                      .zone!
                                                      .type),
                                              isIos: false,
                                              duration:
                                                  Duration(milliseconds: 300),
                                            ));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
