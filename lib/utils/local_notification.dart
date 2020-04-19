import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'build_theme_data.dart';
import 'utils_string.dart';

class LocalNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;
  LocalNotification();

  void init() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    var result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    print("result == $result");
  }

  void showNotificationsAfter({@required Push push}) async {
    await _notificationAfter(push: push);
  }
  Future<void> notificationSchedule() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'Hi there',
        'Subscibe my youtube channel',
        // scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'Channel ID', 'Channel title', 'channel body',
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
    NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        getPushId(), 'Hello there', 'please subscribe my channel', notificationDetails);
  }

  Future<void> _notificationAfter({@required Push push}) async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('second channel ID', 'second Channel title', 'second channel body',
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(push.id, push.title, push.subtitle, push.dateTime, notificationDetails ,payload: "ttttttt");
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print("payLoadpayLoadpayLoadpayLoad = $payLoad");
    }
    print("payLoadpayLoadpayLoadpayLoad = $payLoad");
    // we can set navigator to navigate another screen
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }
  Future<bool> notificationCancel({int id}) async {
   var list = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
   if(list != null){
     for(PendingNotificationRequest pendingNotificationRequest in list){
       if(pendingNotificationRequest.id == id){
         print(pendingNotificationRequest.body);
         await flutterLocalNotificationsPlugin.cancel(id);
         return true;
       }
     }
   }
   return false;
  }
  Future<bool> infoPush({int id}) async {
    var list = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    if(list != null){
      for(PendingNotificationRequest pendingNotificationRequest in list){
        if(pendingNotificationRequest.id == id){
          print(pendingNotificationRequest.body);
          return true;
        }
      }
    }
    return false;
  }
}


//id int
//title String
//subtitle String

class Push {
 final int id;
 final String title;
 final String subtitle;
 final DateTime dateTime;
 Push({this.id, this.title, this.subtitle, this.dateTime});
}
