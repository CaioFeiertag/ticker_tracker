class Ticker {
  final String code;
  final String name;
  final double price;
  final double appreciation;

  Ticker(
      {required this.code,
      required this.name,
      required this.price,
      required this.appreciation});
}

final tickers = [
  new Ticker(code: "ITUB4", name: "Itaú", price: 30.00, appreciation: 1.30),
  new Ticker(code: "ITUB3", name: "Itaú", price: 27.30, appreciation: -1.30),
];
