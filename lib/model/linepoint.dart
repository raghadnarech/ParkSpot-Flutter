class LinePoint {
  var Lat;
  var Lon;
  LinePoint({this.Lat, this.Lon});
  factory LinePoint.empty() {
    return LinePoint(Lat: 0, Lon: 0);
  }
}
