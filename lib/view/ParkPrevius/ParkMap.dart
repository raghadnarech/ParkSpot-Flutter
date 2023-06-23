import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_ripple/flutter_ripple.dart';
import 'package:page_transition/page_transition.dart';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:park_spot/const/constants.dart';
import 'package:park_spot/model/zone.dart';
import 'package:park_spot/provider/MapProvider.dart';
import 'package:park_spot/view/Splash/splash.dart';
import 'package:park_spot/view/ParkPrevius/ParkingDetails.dart';

import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../model/position_opject.dart';

class ParkMap extends StatefulWidget {
  @override
  State<ParkMap> createState() => _ParkMapState();
}

int currentpage = 0;

class _ParkMapState extends State<ParkMap> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool showcard = false;

    MapController controller = MapController();

    PageController _pagecontroller = PageController();

    List<Marker> buildMarker() {
      final markerlist = <Marker>[];
      for (int i = 0; i < mapProvider.listZoneAndDirection!.length; i++) {
        final markeritem = mapProvider.listZoneAndDirection![i];
        markerlist.add(Marker(
            point: LatLng(markeritem.zone!.Lat, markeritem.zone!.Lan),
            builder: ((_) {
              return GestureDetector(
                onTap: (() {
                  setState(() {
                    currentpage = i;
                  });
                  _pagecontroller.animateToPage(currentpage,
                      duration: Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn);
                }),
                child: Icon(
                  Icons.location_on,
                  color: kPrimaryColor,
                  size: 30,
                ),
              );
            })));
      }
      return markerlist;
    }

    List<Polyline> buildLine(int index) {
      final ploylinelist = <Polyline>[];
      final listlatlan = <LatLng>[];

      for (int i = 0;
          i <
              mapProvider
                  .listZoneAndDirection![index].direction!.listpoint!.length;
          i++) {
        final markeritem =
            mapProvider.listZoneAndDirection![index].direction!.listpoint!;
        listlatlan.add(
            LatLng(markeritem.elementAt(i).Lat, markeritem.elementAt(i).Lon));
      }
      for (int i = 0; i < listlatlan.length; i++) {
        final ploylineitem = listlatlan[i];
        ploylinelist.add(Polyline(
            points: listlatlan,
            color: kPrimaryColor.withOpacity(0.03),
            strokeWidth: 5));
      }
      return ploylinelist;
    }

    return ChangeNotifierProvider(
      create: (context) => MapProvider(),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              FlutterMap(
                mapController: controller,
                options: MapOptions(
                  maxZoom: 18,
                  zoom: 11,
                  center: LatLng(33.510414, 36.278336),
                ),
                nonRotatedChildren: [
                  TileLayer(
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/raghadnarech/cle5plpf5001601o3knpxooer/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmFnaGFkbmFyZWNoIiwiYSI6ImNsYWpva2pnNTAwOWYzd3J0d2V4eW5lMXcifQ.TS00nVSRIbtWnuA0N0XtZg",
                    additionalOptions: {
                      'accessToken':
                          "pk.eyJ1IjoicmFnaGFkbmFyZWNoIiwiYSI6ImNsYWpva2pnNTAwOWYzd3J0d2V4eW5lMXcifQ.TS00nVSRIbtWnuA0N0XtZg"
                    },
                  ),
                  PolylineLayer(polylines: buildLine(currentpage)),
                  MarkerLayer(markers: [
                    Marker(
                      point: LatLng(mapProvider.lat, mapProvider.lon),
                      builder: ((context) {
                        return FlutterRipple(
                          radius: 20,
                          rippleColor: kPrimaryColor,
                          duration: Duration(seconds: 2),
                          child: Image.asset("image/icon/dot_location.png",
                              width: 25),
                        );
                      }),
                    )
                  ]),
                  MarkerLayer(markers: buildMarker()),
                ],
              ),
              Positioned(
                right: 20,
                left: 20,
                top: 10,
                height: height * 0.25,
                child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pagecontroller,
                    itemBuilder: ((context, index) {
                      final markeritem =
                          mapProvider.listZoneAndDirection![index].zone!;

                      return CardMarker(marker: markeritem);
                    }),
                    itemCount: mapProvider.ZonerList.length),
              )
            ],
          ),
          floatingActionButton: Consumer<MapProvider>(
            builder: (context, value, child) => FloatingActionButton(
              child: value.isLoadinggetlocation
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Icon(Icons.location_searching),
              onPressed: () async {
                value.checkPermissionAndGetLocation();
                controller.move(LatLng(mapProvider.lat, mapProvider.lon), 14);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CardMarker extends StatelessWidget {
  CardMarker({
    Key? key,
    required this.marker,
  }) : super(key: key);

  Zone marker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
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
                          Expanded(child: AutoSizeText("Park Area")),
                          Expanded(child: AutoSizeText("${marker.Location}")),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(child: AutoSizeText("Park Type")),
                          Expanded(child: AutoSizeText("${marker.type}")),
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
                          Expanded(child: AutoSizeText("Distance")),
                          Expanded(
                            child: AutoSizeText(
                                "${(mapProvider.listZoneAndDirection![currentpage].direction!.distance!).toStringAsFixed(2)} km"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(child: AutoSizeText("Duration")),
                          Expanded(
                            child: AutoSizeText(
                                "${(mapProvider.listZoneAndDirection![currentpage].direction!.duration!).toStringAsFixed(0)} min"),
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
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => kPrimaryColor)),
                        child: AutoSizeText(
                          "Park Here",
                          style: TextStyle(color: kBaseColor, fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: Parking_Details(
                                    idpark: marker.id,
                                    parkname: marker.Location,
                                    parktype: marker.type),
                                isIos: false,
                                duration: Duration(milliseconds: 300),
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
  }
}
