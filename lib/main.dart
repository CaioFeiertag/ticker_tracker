import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ticker_tracker/screens/home/index.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticker Tracker',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Gotham',
      ),
      home: Home(),
    );
  }
}
