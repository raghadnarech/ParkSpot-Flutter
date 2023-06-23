import 'package:park_spot/model/linepoint.dart';
import 'package:park_spot/model/zone.dart';

class Direction {
  List<LinePoint>? listpoint;
  num? duration;
  num? distance;
  Direction({this.listpoint, this.distance, this.duration});
  factory Direction.empty() {
    return Direction(
        distance: 0,
        duration: 0,
        listpoint: [LinePoint.empty(), LinePoint.empty()]);
  }
}
