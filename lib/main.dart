import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  EventChannel eventChannel = EventChannel('samples.flutter.io/charging');

  bool isCharging = false;

  void _onEvent(event) {
    if (event == 'charging' && !isCharging) {
      isCharging = true;
      Fluttertoast.showToast(
          msg:
              "O seu dispositivo está carregando, agora você pode curtir o App sem se preocupar!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (event == 'discharging' && isCharging) {
      isCharging = false;
      Fluttertoast.showToast(
          msg: "Oops! O seu dispositivo foi desconectado do carregador.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red[300],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent);
    Future.delayed(Duration.zero, () {
      notificationProvider
          .initialize()
          .then((_) => {notificationProvider.sendPeriodicallyNotification()});
    });
    Future.delayed(
        Duration.zero,
        () => showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text('Carregando!'),
                  content: new Text(
                      "O seu dispositivo está carregando, agora você pode curtir o App sem se preocupar!"),
                )));
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
