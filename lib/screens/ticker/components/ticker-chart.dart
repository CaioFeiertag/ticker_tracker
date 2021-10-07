/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:ticker_tracker/models/ticker-time-serie.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series<TickerTimeSerie, DateTime>> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(
      {required List<TickerTimeSerie> seriesList, this.animate = false})
      : seriesList = seriesList
            .map((tickerTimeSerie) => new charts.Series(
                  id: 'Ticker',
                  colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                  domainFn: (TickerTimeSerie timeSerie, _) => timeSerie.date,
                  measureFn: (TickerTimeSerie timeSerie, _) => timeSerie.price,
                  data: seriesList,
                ))
            .toList();

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}
