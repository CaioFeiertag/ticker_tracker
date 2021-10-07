import 'package:flutter/material.dart';

class DisplayValue extends StatelessWidget {
  final String label;
  final String value;

  DisplayValue(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text(
        label,
        style: TextStyle(fontSize: 18),
      ),
      Text(
        value,
        style: TextStyle(fontSize: 18),
      ),
    ]);
  }
}
