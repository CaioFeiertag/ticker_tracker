import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ticker_tracker/screens/home/index.dart';
import 'package:ticker_tracker/screens/news/index.dart';
import 'package:ticker_tracker/screens/ticker-more-details/index.dart';
import 'package:ticker_tracker/screens/ticker/index.dart';
import 'package:ticker_tracker/services/notification-provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  NotificationProvider notificationProvider = new NotificationProvider();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      notificationProvider
          .initialize(context)
          .then((_) => {notificationProvider.sendPeriodicallyNotification()});
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticker Tracker',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Gotham',
      ),
      initialRoute: '/',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('pt', ''),
      ],
      routes: {
        '/': (context) => Home(),
        '/ticker': (context) => TickerDetails(),
        '/ticker-more-details': (context) => TickerMoreDetails(),
        '/news': (context) => News(),
      },
    );
  }
}
