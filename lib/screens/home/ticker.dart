class Ticker {
  final String code;
  final String name;
  double? price;
  double? appreciation;

  Ticker(
      {required this.code, required this.name, this.price, this.appreciation});
}

final mostValuableTickers = [
  new Ticker(code: "PETR4.SAO", name: "Petróleo Brasileiro S.A. - Petrobras"),
  new Ticker(code: "VALE3.SAO", name: "Vale S.A"),
  new Ticker(code: "ITUB4.SAO", name: "Itaú Unibanco Holding S.A"),
  new Ticker(code: "BBDC4.SAO", name: "Banco Bradesco S.A"),
];
