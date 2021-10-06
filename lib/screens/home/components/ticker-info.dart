import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticker_tracker/models/ticker.dart';

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
            padding: EdgeInsets.all(8),
            child: ListTile(
                title: Text(
                  this.ticker.code.split(".")[0],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(this.ticker.name,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
                trailing: Wrap(
                    spacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (price != null)
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "R\$ $price",
                                style: TextStyle(fontSize: 18),
                              ),
                              Card(
                                  color: appreciationColor.shade100,
                                  child: Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Text(
                                        appreciation == null
                                            ? ""
                                            : "$appreciation %",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: appreciationColor.shade700),
                                      )))
                            ]),
                      Icon(Icons.arrow_forward_ios)
                    ]))));
  }
}
