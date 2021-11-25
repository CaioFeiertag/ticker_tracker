import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  Future<void> initialize(context) async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    final initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    final initializationSettingsIOS = new IOSInitializationSettings();
    final initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (str) {
      print(str);
      print('oi');
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: new Text('Notificação'),
                content: new Text(str ?? ''),
              ));
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

  sendLowBatteryNotification(double batteryLevel) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('default', 'Default',
            channelDescription:
                'Grant this app the ability to show notifications');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(1, 'Nível de bateria baixo',
        "Nível atual: $batteryLevel", platformChannelSpecifics);
  }
}
