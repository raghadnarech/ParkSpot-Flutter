class Transaction {
  int? id;
  int? cost;
  dynamic date;
  dynamic typepay_id;
  Transaction({this.id, this.cost, this.date, this.typepay_id});
  factory Transaction.fromJson(Map<String, dynamic> responserdata) {
    return Transaction(
        id: responserdata['id'],
        cost: responserdata['cost'],
        date: responserdata['date'],
        typepay_id: responserdata['typepay_id']);
  }
}
