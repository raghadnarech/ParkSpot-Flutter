class Wallet {
  var amount;
  Wallet({this.amount});

  factory Wallet.fromJson(Map<String, dynamic> responsedata) {
    return Wallet(
      amount: responsedata['data'],
    );
  }
}
