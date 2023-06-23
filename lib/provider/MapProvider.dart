import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:park_spot/const/api_url.dart';

import 'package:park_spot/main.dart';
import 'package:park_spot/model/dirctionmarker.dart';
import 'package:park_spot/model/linepoint.dart';

import 'package:park_spot/model/position_opject.dart';
import 'package:park_spot/model/zone.dart';
import 'package:http/http.dart' as http;
import 'package:park_spot/model/zone_and_direction.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Direction direction = Direction();
  List<Direction> listdirection = [];
  bool isLoadinggetallzone = false;
  bool isLoadinggetlocation = false;
  bool isLoading = false;

  Zone? zone;
  List<Zone> ZonerList = [];
  ZoneAndDirection? zoneAndDirection;
  List<ZoneAndDirection>? listZoneAndDirection = [];
  MapController controller = MapController();

  Future<void> getLocation() async {
    isLoadinggetlocation = true;
    notifyListeners();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _myPosition = await PositionObject(position.latitude, position.longitude);
    isLoadinggetlocation = false;
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

  Future<bool> getallZone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int i;
    List<Zone> ZoneList = [];
    isLoadinggetallzone = true;
    notifyListeners();
    try {
      http.Response response = await http.get(
        Uri.parse('$local/user/Get_All_Zone'),
        headers: {
          'Accept': 'application/json',
          'api_key': '123456789',
          'token': token!
        },
      );
      if (response.statusCode == 200) {
        dynamic data = await json.decode(response.body);
        var zones = data['data'];
        ZonerList = [];
        listdirection = [];
        listZoneAndDirection = [];
        for (i = 0; i < zones.length; i++) {
          zone = Zone(
            id: zones[i]['id'],
            type: zones[i]['type'],
            ac_capacity: zones[i]['capacity'],
            Location: zones[i]['name'],
            Lat: zones[i]['lat'] as double,
            Lan: zones[i]['lan'] as double,
          );
          ZonerList.add(zone!);
          direction = await getDirectionsAPIResponse(i);
          listdirection.add(direction);
          zoneAndDirection = ZoneAndDirection(direction: direction, zone: zone);
          listZoneAndDirection!.add(zoneAndDirection!);
        }
        listdirection.sort((a, b) => a.distance! < b.distance! ? 0 : 1);
        listZoneAndDirection!.sort(
            (a, b) => a.direction!.distance! < b.direction!.distance! ? 0 : 1);
        notifyListeners();
        isLoadinggetallzone = false;
        notifyListeners();
        return true;
      } else {
        isLoadinggetallzone = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoadinggetallzone = false;
      notifyListeners();
      return false;
    }
  }

  Future<Direction> getDirectionsAPIResponse(int index) async {
    try {
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
      return direction;
    } catch (e) {
      return Direction.empty();
    }
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
}
