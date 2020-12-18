
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class LocalNotifyManager
{
  FlutterLocalNotificationsPlugin _flutterLocationNotify;
  var initSetting;
  BehaviorSubject<RecetiveNotification> get didReceiveLocalNotificationSubject => BehaviorSubject<RecetiveNotification>();


  
  LocalNotifyManager.init()
  {
    _flutterLocationNotify = FlutterLocalNotificationsPlugin();

    //check platform
    if(Platform.isIOS)
    {
      requestIOSpermission();
    }
    initializaPlatorm();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Ho_Chi_Minh")); 
  }

  void requestIOSpermission() 
  {
    _flutterLocationNotify.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>().requestPermissions
    (
      alert: true,
      badge: true,
      sound: true
    );
  }

  void initializaPlatorm() 
  {
    var initSettingAndroid =AndroidInitializationSettings("@mipmap/ic_launcher");
    var initSettingIOS = IOSInitializationSettings
    (
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async
      {
        RecetiveNotification notification = RecetiveNotification(id: id, title: title, body: body, payload: payload);
        didReceiveLocalNotificationSubject.add(notification);
      },
    );

    initSetting = InitializationSettings
    (
      android: initSettingAndroid, 
      iOS: initSettingIOS
    );
  }
  setOnNotificationReceive( Function onNotificationReceive)
  {
    didReceiveLocalNotificationSubject.listen
    (
      (value) 
      {
        onNotificationReceive(value);
      }
    );
  }
    
  //onclick event
  setOnNotificationClick(Function onNotificationClick) async
  {
    await _flutterLocationNotify.initialize
    (
      initSetting,
      onSelectNotification: (String payload) async
      {
        onNotificationClick(payload);
      }
    );
  }

  //display notification
  Future<void> showNotification() async
  {
    //on android
    var androidChanel = AndroidNotificationDetails
    (
      "CHANNEL_ID", "CHANNEL_NAME", "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      
    );
    //on ios
    var iosChannel =IOSNotificationDetails();

    var platformChannel =NotificationDetails
    (
      android: androidChanel,
      iOS: iosChannel,
    );

    await _flutterLocationNotify.show
    (
      0, //id
      "Test title",  //title
      "Test Body", //body
      platformChannel,  //
      payload: "New payload"  //payload
    );
  }

  //schedules Notification
  Future<void> schedulesNotification(DateTime dateTime ) async
  {
    //set time 
    var schedulesNotificationDataTime = tz.TZDateTime(tz.local,dateTime.year, dateTime.month, dateTime.day, dateTime.hour,dateTime.minute);
    //on android
    var androidChanel = AndroidNotificationDetails
    (
      "CHANNEL_ID", "CHANNEL_NAME", "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      
    );
    //on ios
    var iosChannel =IOSNotificationDetails();

    var platformChannel =NotificationDetails
    (
      android: androidChanel,
      iOS: iosChannel,
    );

    await _flutterLocationNotify.zonedSchedule
    (
      0, //id
      "Schedules Test title",  //title
      "Schedules Test Body",
      schedulesNotificationDataTime, //body
      platformChannel,  //
      payload: "Schedules New payload",
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, 
      androidAllowWhileIdle: true  //payload
    );
  }
    //repeat Notification
  Future<void> repeatNotification() async
  {
    //on android
    var androidChanel = AndroidNotificationDetails
    (
      "CHANNEL_ID", "CHANNEL_NAME", "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      
    );
    //on ios
    var iosChannel =IOSNotificationDetails();

    var platformChannel =NotificationDetails
    (
      android: androidChanel,
      iOS: iosChannel,
    );

    await _flutterLocationNotify.periodicallyShow
    (
      0, //id
      "Schedules Test title",  //title
      "Schedules Test Body",
      RepeatInterval.everyMinute, //body
      platformChannel,  //
      payload: "Schedules New payload",
      androidAllowWhileIdle: true  //payload
    );
  }

}
LocalNotifyManager localNotifyManager = LocalNotifyManager.init();
class RecetiveNotification
{
  final int id;
  final String title;
  final String body; 
  final String payload;
  RecetiveNotification
  (
    {
      @required this.id,
      @required this.title,
      @required this.body,
      @required this.payload,
    }
  );
}