import 'dart:convert';

import 'package:ticker_tracker/models/tickerDB.dart';

class Ticker extends TickerDB {
  final String code;
  final String name;
  bool inPortfolio;
  double? price;
  double? openPrice;
  double? appreciation;
  double? highestPrice;
  double? volume;
  String? lastTradingDay;
  double? previousClosePrice;
  double? changeAbsolute;

  Ticker(
      {required this.code,
      required this.name,
      required this.inPortfolio,
      this.price,
      this.appreciation})
      : super(code: code, name: name);

  Ticker.fromJson(
      {required this.code,
      required this.name,
      required this.inPortfolio,
      required String json})
      : super(code: code, name: name) {
    final data = jsonDecode(json);
    if (data["Global Quote"] != null) {
      this.price = double.parse(data["Global Quote"]["05. price"]);
      this.appreciation = double.parse(
          data["Global Quote"]["10. change percent"].split("%")[0]);
      this.openPrice = double.parse(data["Global Quote"]["02. open"]);
      this.highestPrice = double.parse(data["Global Quote"]["03. high"]);
      this.volume = double.parse(data["Global Quote"]["06. volume"]);
      this.lastTradingDay = data["Global Quote"]["07. latest trading day"];
      this.previousClosePrice =
          double.parse(data["Global Quote"]["08. previous close"]);
      this.changeAbsolute = double.parse(data["Global Quote"]["09. change"]);
    }
  }
}

// final mostValuableTickers = [
//   new Ticker(code: "PETR4.SAO", name: "Petróleo Brasileiro S.A. - Petrobras"),
//   new Ticker(code: "VALE3.SAO", name: "Vale S.A"),
//   new Ticker(code: "ITUB4.SAO", name: "Itaú Unibanco Holding S.A"),
//   new Ticker(code: "BBDC4.SAO", name: "Banco Bradesco S.A"),
// ];
