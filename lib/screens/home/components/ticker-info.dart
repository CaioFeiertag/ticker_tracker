import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticker_tracker/screens/home/ticker.dart';

class TickerInfo extends StatelessWidget {
  TickerInfo({required this.ticker}) : super();

  final Ticker ticker;

  @override
  Widget build(BuildContext context) {
    String? price = this.ticker.price?.toStringAsFixed(2);
    String? appreciation = this.ticker.appreciation?.toStringAsFixed(2);
    MaterialColor appreciationColor = Colors.grey;

    if (this.ticker.appreciation != null) {
      appreciationColor =
          this.ticker.appreciation! > 0 ? Colors.green : Colors.red;
    }

    return Card(
        child: Padding(
            padding: EdgeInsets.all(20),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.ticker.code,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(this.ticker.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal))
                      ])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(
                  price == null ? "" : "R\$ $price",
                  style: TextStyle(fontSize: 24),
                ),
                Card(
                    color: appreciationColor.shade100,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          appreciation == null ? "" : "$appreciation %",
                          style: TextStyle(
                              fontSize: 24, color: appreciationColor.shade700),
                        )))
              ])
            ])));
  }
}
