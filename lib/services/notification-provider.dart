import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationProvider {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    final initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    final initializationSettingsIOS = new IOSInitializationSettings();
    final initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (str) {
      Fluttertoast.showToast(
          msg:
              "Notificação recebida: veja o desempenhho dos tickers de seu portfólio.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    await createNotificationChannel();
  }

  Future<void> createNotificationChannel() async {
    // Initialize your Notification channel object
    final channel = new AndroidNotificationChannel('default', 'Default',
        description: 'Grant this app the ability to show notifications',
        importance: Importance.high);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  sendPeriodicallyNotification() {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('default', 'Default',
            channelDescription:
                'Grant this app the ability to show notifications');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'Bolsa de valores fechou!',
        'Abra o App e acompanhe as mudanças que ocorreram na bolsa de valores no dia de hoje.',
        RepeatInterval.everyMinute,
        platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }
}
