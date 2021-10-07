import 'package:flutter/material.dart';
import 'package:ticker_tracker/models/ticker.dart';
import 'package:ticker_tracker/screens/home/ticket-api.dart';
import 'package:ticker_tracker/screens/ticker-more-details/components/display-value.dart';

class TickerMoreDetailsArguments {
  final Ticker ticker;

  TickerMoreDetailsArguments(this.ticker);
}

class TickerMoreDetails extends StatefulWidget {
  @override
  _TickerMoreDetails createState() => _TickerMoreDetails();
}

class _TickerMoreDetails extends State<TickerMoreDetails> {
  late TickerMoreDetailsArguments args;
  late Ticker ticker;
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context)!.settings.arguments
          as TickerMoreDetailsArguments;

      setState(() {
        ticker = args.ticker;
      });

      if (args.ticker.price == null) {
        fetchTicker(ticker).then((response) => {
              setState(() {
                ticker = response;
              })
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(ticker.name),
        ),
        body: Card(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DisplayValue("Valor Abertura", ticker.openPrice.toString()),
                    DisplayValue("Valor Máximo", ticker.highestPrice.toString())
                  ])),
          Padding(
              padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DisplayValue(
                        "Alteração absoluta", ticker.changeAbsolute.toString()),
                    DisplayValue("Valor fechamento",
                        ticker.previousClosePrice.toString())
                  ])),
        ])));
  }
}
