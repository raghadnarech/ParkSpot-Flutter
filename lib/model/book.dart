class Book {
  int? id;
  String? country;
  int? num_car;
  String? date;
  int? hours;
  String? startTime;
  String? endTime;
  String? zonename;
  String? parkspot;
  int? calctime;

  Book(
      {this.country,
      this.date,
      this.endTime,
      this.hours,
      this.id,
      this.num_car,
      this.parkspot,
      this.startTime,
      this.zonename,
      this.calctime});

  factory Book.fromJson(Map<String, dynamic> responserdata) {
    return Book(
      country: responserdata["country"],
      num_car: responserdata["num_car"],
      date: responserdata["date"],
      endTime: responserdata["endTime_book"],
      hours: responserdata["hours"],
      id: responserdata["id"],
      zonename: responserdata["zone_name"],
      startTime: responserdata["startTime_book"],
      parkspot: responserdata["park_spot"],
      calctime: responserdata["calc_time"],
    );
  }
  factory Book.empty() {
    return Book(
      country: "",
      num_car: 0,
      date: "",
      endTime: "00:00:00:00",
      hours: 1,
      id: 0,
      zonename: "",
      startTime: "00:00:00:00",
      parkspot: "",
      calctime: 60,
    );
  }
}
