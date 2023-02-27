import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class PositionObject {
  double latitude;
  double longitude;

  PositionObject(this.latitude, this.longitude);

  factory PositionObject.empty() {
    return PositionObject(36, 30);
  }
}
