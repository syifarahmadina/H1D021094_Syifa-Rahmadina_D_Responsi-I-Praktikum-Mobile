class MataUang {
  String? id;
  String? currency;
  int? exchangeRate;
  String? symbol;

  MataUang({this.id, this.currency, this.exchangeRate, this.symbol});

  factory MataUang.fromJson(Map<String, dynamic> obj) {
    return MataUang(
      id: obj['id'],
      currency: obj['currency'],
      exchangeRate: obj['exchange_rate'],
      symbol: obj['symbol'],
    );
  }
}