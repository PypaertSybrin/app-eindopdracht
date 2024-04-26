import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialize native Ios Notifications
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    tz.initializeTimeZones();
  }

  // void showNotificationAndroid(String title, String value) async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('channel_id', 'Channel Name',
  //           channelDescription: 'Channel Description',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker');

  //   int notification_id = 1;
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);

  //   await flutterLocalNotificationsPlugin.show(
  //       notification_id, title, value, notificationDetails,
  //       payload: 'Not present');
  // }

  Future<int> showTimedNotification(
      String title, String description, int value) async {
    int notificationId = generateUniqueId();

    await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        title,
        description,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: value)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    return notificationId;
  }

  Future deleteNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  int generateUniqueId() {
    // Get the current timestamp
    int random1 = Random().nextInt(999);
    int random2 = Random().nextInt(999);
    int random3 = Random().nextInt(999);

    // Concatenate and return a unique integer
    return int.parse('$random1$random2$random3');
  }
}
