import 'package:flutter/material.dart';
import 'package:ticker_tracker/models/ticker.dart';
import 'package:ticker_tracker/screens/ticker-more-details/components/display-value.dart';

class TickerMoreDetailsArguments {
  final Ticker ticker;

  TickerMoreDetailsArguments(this.ticker);
}

class TickerMoreDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as TickerMoreDetailsArguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(args.ticker.name),
        ),
        body: Card(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DisplayValue(
                        "Valor Abertura", args.ticker.openPrice.toString()),
                    DisplayValue(
                        "Valor Máximo", args.ticker.highestPrice.toString())
                  ])),
          Padding(
              padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DisplayValue("Alteração absoluta",
                        args.ticker.changeAbsolute.toString()),
                    DisplayValue("Valor fechamento",
                        args.ticker.previousClosePrice.toString())
                  ])),
        ])));
  }
}
