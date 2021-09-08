import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticker_tracker/screens/home/ticker.dart';

class TickerInfo extends StatelessWidget {
  TickerInfo({required this.ticker}) : super();

  final Ticker ticker;

  @override
  Widget build(BuildContext context) {
    String price = this.ticker.price.toStringAsFixed(2);
    String appreciation = this.ticker.appreciation.toStringAsFixed(2);

    MaterialColor appreciationColor =
        this.ticker.appreciation > 0 ? Colors.green : Colors.red;

    return Card(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(children: [
              Column(children: [
                Text(
                  this.ticker.code,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(this.ticker.name,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal))
              ]),
              Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Text(
                    "R\$ $price",
                    style: TextStyle(fontSize: 24),
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Card(
                      color: appreciationColor.shade100,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Text(
                            "$appreciation %",
                            style: TextStyle(
                                fontSize: 24,
                                color: appreciationColor.shade700),
                          ))))
            ])));
  }
}
