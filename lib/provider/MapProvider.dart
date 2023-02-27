import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:park_spot/main.dart';
import 'package:park_spot/model/dirctionmarker.dart';
import 'package:park_spot/model/linepoint.dart';

import 'package:park_spot/model/position_opject.dart';
import 'package:park_spot/model/zone.dart';
import 'package:http/http.dart' as http;
import 'package:park_spot/model/zone_and_direction.dart';

class MapProvider with ChangeNotifier {
  String baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  bool showmarker = false;

  String navType = 'driving';
  List? geometry;
  num duration = 0;
  num distance = 0;
  LinePoint? point;
  List<LinePoint> listerPoint = [];
  PositionObject? _myPosition;
  Direction? direction;
  List<Direction> listdirection = [];
  bool? _isLoading;
  Zone? zone;
  List<Zone> ZonerList = [];
  ZoneAndDirection? zoneAndDirection;
  List<ZoneAndDirection>? listZoneAndDirection = [];
  MapController controller = MapController();
  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _myPosition = await PositionObject(position.latitude, position.longitude);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> checkPermissionAndGetLocation() async {
    Future.delayed(Duration(seconds: 5));
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await getLocation();
    } else {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        await getLocation();
      } else {
        _myPosition = PositionObject.empty();
      }
    }
    notifyListeners();
  }

  Future<void> getallZone() async {
    int i;
    List<Zone> ZoneList = [];
    _isLoading = true;
    http.Response response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/getallzone'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    List<dynamic> data = await json.decode(response.body);
    ZonerList = [];
    listdirection = [];
    listZoneAndDirection = [];
    print(data.length);
    for (i = 0; i < data.length; i++) {
      zone = Zone(
        id: data[i]['id'],
        type: data[i]['Type'],
        busy_Capacity: data[i]['busy_Capacity'],
        ac_capacity: data[i]['ac_capacity'],
        Location: data[i]['Location'],
        Lat: data[i]['Lat'] as double,
        Lan: data[i]['Lan'] as double,
      );

      ZonerList.add(zone!);
      print(ZonerList);
      direction = await getDirectionsAPIResponse(i);
      listdirection.add(direction!);
      zoneAndDirection = ZoneAndDirection(direction: direction, zone: zone);
      listZoneAndDirection!.add(zoneAndDirection!);
    }
    print(ZonerList);
    listdirection.sort((a, b) => a.distance! < b.distance! ? 0 : 1);
    listZoneAndDirection!.sort(
        (a, b) => a.direction!.distance! < b.direction!.distance! ? 0 : 1);
    print(listdirection);
    print(ZonerList);
    print(listZoneAndDirection);
    _isLoading = false;
    notifyListeners();
  }

  Future<Direction> getDirectionsAPIResponse(int index) async {
    http.Response responsedata = await http.get(
      Uri.parse(
          'https://api.mapbox.com/directions/v5/mapbox/driving/${lon},${lat};${ZonerList[index].Lan},${ZonerList[index].Lat}?alternatives=true&geometries=geojson&language=en&overview=simplified&steps=true&access_token=pk.eyJ1IjoicmFnaGFkbmFyZWNoIiwiYSI6ImNsYWpva2pnNTAwOWYzd3J0d2V4eW5lMXcifQ.TS00nVSRIbtWnuA0N0XtZg'),
    );
    dynamic response = json.decode(responsedata.body);
    int i;
    geometry = await response['routes'][0]['geometry']['coordinates'];
    duration = await response['routes'][0]['duration'];
    distance = await response['routes'][0]['distance'];

    List<LinePoint> listpoint = [];
    listerPoint = [];
    for (i = 0; i < geometry!.length; i++) {
      point = LinePoint(
        Lat: geometry![i][1],
        Lon: geometry![i][0],
      );
      listerPoint.add(point!);
    }

    duration = duration / 60;
    distance = distance / 1000;

    direction = Direction(
        listpoint: listerPoint, distance: distance, duration: duration);
    return direction!;
  }

  buildMaptoMarker({Lat, Lon}) {
    controller.move(LatLng(Lat, Lon), 14);
    notifyListeners();
  }

  get lat {
    return _myPosition!.latitude;
  }

  get lon {
    return _myPosition!.longitude;
  }

  get mapcontroller {
    return controller;
  }

  get isLoading {
    return _isLoading;
  }
}
