import 'package:flutter/material.dart';
import 'package:ticker_tracker/screens/home/components/ticker-info.dart';
import 'package:ticker_tracker/screens/home/ticker.dart';
import 'package:ticker_tracker/screens/home/ticketApi.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Ticker> tickers = mostValuableTickers;

  @override
  void initState() {
    super.initState();
    Future.wait(tickers.map((ticker) {
      return fetchTicker(ticker);
    })).then((updatedTickers) => {setState(() {})});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: ListView.builder(
            itemCount: tickers.length,
            itemBuilder: (BuildContext context, int index) {
              Ticker ticker = tickers[index];

              return TickerInfo(ticker: ticker);
            }));
  }
}
