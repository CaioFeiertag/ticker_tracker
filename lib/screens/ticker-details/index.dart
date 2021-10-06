import 'package:flutter/material.dart';
import 'package:ticker_tracker/screens/home/ticker.dart';
import 'package:ticker_tracker/services/Ticker-provider.dart' as Provider;

class TickerDetails extends StatelessWidget {
  final Ticker ticker;

  TickerDetails({Key? key, required this.ticker}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tickerProvider = Provider.TickerProvider();

    return Scaffold(
        appBar: AppBar(
            title: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(this.ticker.name)],
        )),
        body: Stack(children: [
          Center(
              child: ElevatedButton(
                  onPressed: () => {
                        tickerProvider.addTicker(this.ticker),
                        Navigator.pop(context)
                      },
                  child: Text("Adicionar ao portifólio")))
        ]));
  }
}
