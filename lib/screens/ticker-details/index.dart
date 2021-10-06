import 'package:flutter/material.dart';
import 'package:ticker_tracker/models/ticker-time-serie.dart';
import 'package:ticker_tracker/models/ticker.dart';
import 'package:ticker_tracker/screens/home/ticket-api.dart';
import 'package:ticker_tracker/screens/ticker-details/components/ticker-chart.dart';
import 'package:ticker_tracker/services/Ticker-provider.dart' as Provider;

class TickerDetails extends StatefulWidget {
  final Ticker ticker;

  TickerDetails({Key? key, required this.ticker}) : super(key: key);

  @override
  _TickerDetails createState() => _TickerDetails(ticker: ticker);
}

class _TickerDetails extends State<TickerDetails> {
  final Ticker ticker;
  late List<TickerTimeSerie> tickerTimeSeries = [];
  final tickerProvider = Provider.TickerProvider();

  _TickerDetails({required this.ticker});

  @override
  void initState() {
    super.initState();

    fetchTickerTimeSeries(ticker).then((response) => {
          setState(() {
            tickerTimeSeries = response;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(this.ticker.name)],
        )),
        body: Column(children: [
          Expanded(
              child: SimpleTimeSeriesChart(seriesList: this.tickerTimeSeries)),
          Padding(
              padding: EdgeInsets.all(6),
              child: ElevatedButton(
                  onPressed: () => {
                        tickerProvider.addTicker(this.ticker),
                        Navigator.pop(context)
                      },
                  child: Text("Adicionar ao portifólio")))
        ]));
  }
}
