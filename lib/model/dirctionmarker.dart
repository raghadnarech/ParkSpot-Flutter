import 'package:park_spot/model/linepoint.dart';
import 'package:park_spot/model/zone.dart';

class Direction {
  List<LinePoint>? listpoint;
  num? duration;
  num? distance;
  Direction({this.listpoint, this.distance, this.duration});
}
