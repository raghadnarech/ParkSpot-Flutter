import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_spot/const/constants.dart';
import 'package:park_spot/provider/MapProvider.dart';
import 'package:park_spot/view/home.dart';
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
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: height * 0.2,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.location_on),
                                    MaterialButton(
                                      child: Text(
                                        "احجز الآن",
                                        style: TextStyle(
                                            color: kBaseColor, fontSize: 18),
                                      ),
                                      onPressed: () {},
                                      color: kPrimaryColor,
                                    )
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      mapProvider.listZoneAndDirection![index]
                                          .zone!.type
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(mapProvider
                                        .listZoneAndDirection![index]
                                        .zone!
                                        .Location
                                        .toString()),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        'Duration: ${mapProvider.listZoneAndDirection![index].direction!.duration!.toStringAsFixed(0)} min'),
                                    Text(
                                        'Distance: ${mapProvider.listZoneAndDirection![index].direction!.distance!.toStringAsFixed(2)} km'),
                                  ],
                                )),
                              ],
                            ),
                          )
                        ],
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
