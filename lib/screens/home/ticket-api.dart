import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ticker_tracker/models/ticker-time-serie.dart';
import 'package:ticker_tracker/models/tickerDB.dart';
import 'package:ticker_tracker/models/ticker.dart';
import 'package:http/http.dart' as http;

final alphaVantageKey = dotenv.get('ALPHA_VANTAGE_KEY');

Future<Ticker> fetchTicker(TickerDB ticker) async {
  final response = await http.get(Uri.parse(
      "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=${ticker.code}&apikey=$alphaVantageKey&datatype=json"));

  if (response.statusCode == 200) {
    return new Ticker.fromJson(
      code: ticker.code,
      name: ticker.name,
      inPortfolio: true,
      json: response.body,
    );
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
              code: tickerData["1. symbol"],
              name: tickerData["2. name"],
              inPortfolio: false))
        });

    return tickers;
  } else {
    throw Exception("Failed to search tickers");
  }
}

Future<List<TickerTimeSerie>> fetchTickerTimeSeries(TickerDB ticker) async {
  final response = await http.get(Uri.parse(
      "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=${ticker.code}&apikey=$alphaVantageKey&datatype=json"));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final timeSeries = data["Time Series (Daily)"] as Map;
    final List<TickerTimeSerie> tickers = [];

    for (final date in timeSeries.keys) {
      tickers.add(new TickerTimeSerie(
          date: DateTime.parse(date),
          price: double.parse(timeSeries[date]["4. close"])));
    }

    return tickers;
  } else {
    throw Exception("Failed to search tickers");
  }
}
