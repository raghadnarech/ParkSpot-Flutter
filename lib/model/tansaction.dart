class Transaction {
  int? id;
  int? cost;
  Transaction({this.id, this.cost});
  factory Transaction.fromJson(Map<String, dynamic> responserdata) {
    return Transaction(
      id: responserdata['id'],
      cost: responserdata['cost'],
    );
  }
}
