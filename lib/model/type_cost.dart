class TypeCost {
  int? id;
  String? type;
  int? cost;

  TypeCost({this.cost, this.id, this.type});
  factory TypeCost.fromJson(Map<String, dynamic> responsedata) {
    return TypeCost(
        id: responsedata['id'] ?? 0,
        type: responsedata['type'] ?? "null",
        cost: responsedata['cost'] ?? 0);
  }
}
