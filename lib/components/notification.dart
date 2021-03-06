
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

  //daily notification
  Future<void> dailyNotification(DateTime dateTime , int id , String title , String body) async
  {
    var _time = Time(dateTime.hour,dateTime.minute,dateTime.second);
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

    // ignore: deprecated_member_use
    await _flutterLocationNotify.showDailyAtTime
    (
      id, //id
      title,  //title
      body, //body
      _time,
      platformChannel,  //
      payload: "New payload",  //payload //payload
    );
  }


  //schedules Notification
  Future<void> schedulesNotification(DateTime dateTime , int id , String title , String body ) async
  {
    var schedulesNotificationDataTime;
    //set time 
    dateTime != null 
    ? schedulesNotificationDataTime = tz.TZDateTime(tz.local,dateTime.year, dateTime.month, dateTime.day, dateTime.hour,dateTime.minute)
    : schedulesNotificationDataTime = null;
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
      id, //id
      title,  //title
      body, //body
      schedulesNotificationDataTime, 
      platformChannel,  //
      payload: "Schedules New payload",
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, 
      androidAllowWhileIdle: true  //payload
    );
  }
    //repeat Notification
  Future<void> repeatNotification(int id , String title , String body) async
  {
    //on android
    var androidChanel = AndroidNotificationDetails
    (
      "CHANNEL_ID", "CHANNEL_NAME", "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableLights: true
      
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
      id, //id
      title,  //title
      body, // body
      RepeatInterval.daily,
      platformChannel,  //
      payload: "Schedules New payload",
      androidAllowWhileIdle: true  //payload
    );
  }

  //cancel notification
  Future<void> cancelNotification(int id) async
  {
    await _flutterLocationNotify.cancel(id);
  }

  //cancel all notification
  Future<void> cancelAllNotification() async
  {
    await _flutterLocationNotify.cancelAll();
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