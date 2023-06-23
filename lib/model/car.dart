class Car {
  String? Country;
  String? NumCar;
  String? Type;
  String? Color;
  Car({
    this.Color,
    this.Country,
    this.NumCar,
    this.Type,
  });

  factory Car.fromJson(Map<String, dynamic> responsedata) {
    return Car(
      Color: responsedata['color'],
      Country: responsedata['country'],
      NumCar: responsedata['num_car'],
      Type: responsedata['type'],
    );
  }
}
