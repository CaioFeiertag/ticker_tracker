import 'package:flutter/material.dart';
import 'package:ticker_tracker/models/ticker-time-serie.dart';
import 'package:ticker_tracker/models/ticker.dart';
import 'package:ticker_tracker/screens/home/ticket-api.dart';
import 'package:ticker_tracker/screens/ticker-more-details/index.dart';
import 'package:ticker_tracker/screens/ticker/components/ticker-chart.dart';
import 'package:ticker_tracker/services/Ticker-provider.dart' as Provider;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ticker_tracker/shared/components/bottom-navigator.dart';

class TickerDetailsArguments {
  Ticker ticker;

  TickerDetailsArguments(this.ticker);
}

class TickerDetails extends StatefulWidget {
  @override
  _TickerDetails createState() => _TickerDetails();
}

class _TickerDetails extends State<TickerDetails> {
  late List<TickerTimeSerie> tickerTimeSeries = [];
  final tickerProvider = Provider.TickerProvider();
  late TickerDetailsArguments args;
  Ticker? ticker;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      args =
          ModalRoute.of(context)!.settings.arguments as TickerDetailsArguments;
      setState(() {
        ticker = args.ticker;
      });
      fetchTickerTimeSeries(args.ticker).then((response) => {
            setState(() {
              tickerTimeSeries = response;
            })
          });
    });
  }

  void toggleTicker() {
    if (ticker!.inPortfolio) {
      tickerProvider.deleteTicker(this.ticker!);
      ticker!.inPortfolio = false;
    } else {
      tickerProvider.addTicker(this.ticker!);
      ticker!.inPortfolio = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Wrap(
          children: [Text(this.ticker?.name ?? '')],
        )),
        bottomNavigationBar: BottomNavigator("/ticker"),
        body: Column(children: [
          Expanded(
              child: SimpleTimeSeriesChart(seriesList: this.tickerTimeSeries)),
          Padding(
              padding: EdgeInsets.all(6),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: toggleTicker,
                        style: ButtonStyle(
                            backgroundColor: BackgroundButtonColor(
                                ticker?.inPortfolio ?? false,
                                Theme.of(context).colorScheme.primary.value)),
                        child: Text(!(ticker?.inPortfolio ?? false)
                            ? AppLocalizations.of(context)!.addToPortfolio
                            : AppLocalizations.of(context)!
                                .removeFromPortfolio)),
                    ElevatedButton(
                        onPressed: () => {
                              Navigator.pushNamed(
                                  context, '/ticker-more-details',
                                  arguments:
                                      TickerMoreDetailsArguments(ticker!))
                            },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.blue.shade500)),
                        child: Text(AppLocalizations.of(context)!.showMore))
                  ])),
        ]));
  }
}

class BackgroundButtonColor extends MaterialStateColor {
  final bool inPortfolio;
  final int defaultValue;

  BackgroundButtonColor(this.inPortfolio, this.defaultValue)
      : super(defaultValue);

  @override
  Color resolve(Set<MaterialState> states) {
    if (!this.inPortfolio) {
      return Color(defaultValue);
    }
    return Colors.red;
  }
}
