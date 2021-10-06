import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ticker_tracker/models/tickerDB.dart';
import 'package:ticker_tracker/screens/home/ticker.dart';
import 'package:http/http.dart' as http;

final alphaVantageKey = dotenv.get('ALPHA_VANTAGE_KEY');

Future<Ticker> fetchTicker(TickerDB ticker) async {
  final response = await http.get(Uri.parse(
      "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=${ticker.code}&apikey=$alphaVantageKey&datatype=json"));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final price = double.parse(data["Global Quote"]["05. price"]);
    final appreciation = double.parse(data["Global Quote"]["09. change"]);

    return new Ticker(
        code: ticker.code,
        name: ticker.name,
        price: price,
        appreciation: appreciation);
  } else {
    throw Exception("Failed to load ticker ${ticker.code}");
  }
}

Future<List<Ticker>> searchTicker(String keywords) async {
  final response = await http.get(Uri.parse(
      "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$keywords&apikey=$alphaVantageKey&datatype=json"));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final bestMatches = data["bestMatches"] as List;
    final List<Ticker> tickers = [];

    bestMatches.forEach((tickerData) => {
          tickers.add(new Ticker(
              code: tickerData["1. symbol"], name: tickerData["2. name"]))
        });

    return tickers;
  } else {
    throw Exception("Failed to search tickers");
  }
}