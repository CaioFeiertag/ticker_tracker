import 'package:flutter/material.dart';
import 'package:ticker_tracker/models/ticker.dart';
import 'package:ticker_tracker/screens/home/ticket-api.dart';
import 'package:ticker_tracker/screens/ticker-more-details/components/display-value.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ticker_tracker/shared/components/bottom-navigator.dart';

class TickerMoreDetailsArguments {
  Ticker ticker;

  TickerMoreDetailsArguments(this.ticker);
}

class TickerMoreDetails extends StatefulWidget {
  @override
  _TickerMoreDetails createState() => _TickerMoreDetails();
}

class _TickerMoreDetails extends State<TickerMoreDetails> {
  late TickerMoreDetailsArguments args;
  Ticker? ticker;
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      args = ModalRoute.of(context)!.settings.arguments
          as TickerMoreDetailsArguments;

      setState(() {
        ticker = args.ticker;
      });

      if (args.ticker.price == null) {
        fetchTicker(args.ticker).then((response) => {
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
          title: Text(ticker?.name ?? ''),
        ),
        bottomNavigationBar: BottomNavigator("/ticker-details"),
        body: Card(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DisplayValue(AppLocalizations.of(context)!.openingValue,
                        (ticker?.openPrice ?? 0).toString()),
                    DisplayValue(AppLocalizations.of(context)!.maxValue,
                        (ticker?.highestPrice ?? 0).toString())
                  ])),
          Padding(
              padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DisplayValue(AppLocalizations.of(context)!.absAlteration,
                        (ticker?.changeAbsolute ?? 0).toString()),
                    DisplayValue(AppLocalizations.of(context)!.closeValue,
                        (ticker?.previousClosePrice ?? 0).toString())
                  ])),
        ])));
  }
}
