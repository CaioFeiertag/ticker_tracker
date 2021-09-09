import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ticker_tracker/screens/home/ticker.dart';
import 'package:http/http.dart' as http;

Future<Ticker> fetchTicker(Ticker ticker) async {
  final alphaVantageKey = dotenv.get('ALPHA_VANTAGE_KEY');

  final response = await http.get(Uri.parse(
      "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=${ticker.code}&apikey=$alphaVantageKey&datatype=json"));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    ticker.price = double.parse(data["Global Quote"]["05. price"]);
    ticker.appreciation = double.parse(data["Global Quote"]["09. change"]);

    return ticker;
  } else {
    throw Exception("Failed to load ticker ${ticker.code}");
  }
}
