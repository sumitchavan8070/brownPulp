import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project/utilities/constants/global_var.dart';
import 'package:project/utilities/navigation/go_paths.dart';
import 'package:project/utilities/navigation/my_navigator.dart';
import 'package:project/utilities/theme/app_colors.dart';

class FCMNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> updateFCMToken() async {
    _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();

    print("FCM TOKEN $fcmToken ");
    print("Firebase Instance Id : ---------=>  ${fcmToken?.split(":").first}-------- <= ");

    // _fcmTokenController.fcmTokenApi(fcmToken);
  }

  Future<void> clearFCMToken() async {
    _firebaseMessaging.deleteToken();
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        // AndroidInitializationSettings('mipmap/ic_notification');
        AndroidInitializationSettings('mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // ------- Android notification click handler
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        try {
          print("Notification clicked ${details.payload}");

          final Map payload = json.decode(details.payload ?? "flutterLocalNotificationsPlugin");
          onNotificationClicked(payload: payload, path: "flutterLocalNotificationsPlugin");
        } catch (e) {
          print("onDidReceiveNotificationResponse error $e");
        }
      },
    );
  }

  onNotificationClicked({required Map payload, required String path}) async {
    print("----------------------------- called from || $path -----------------------------------");


    print("payload data ----------------------------------------------------------------------- $payload");

    // TODO : To handle a click event on a notification and navigate to a web view when the notification is clicked

    if (payload.containsKey('route')) {
      if (GlobalVars.isLoggedIn == true ) {
        if (payload.containsKey("coupon")) {
          print("-------- 1 --------");

          
          MyNavigator.pushNamed(payload['route'], extra: payload);


          print("--------------------- here is the navigator start   --------------");
    
          return;
        }

        MyNavigator.pushNamed(payload['route'], extra: payload);
      }
      return;
    }
    if (payload.containsKey("launchUrl")) {
      // canla.launchUrl(payload['launchUrl']);
      // launchUrl(
      //   Uri.parse(payload['launchUrl']),
      //   mode: LaunchMode.externalApplication,
      // );
      return;
    }
    // by default route
    print(" ---------------------- BY DEFAULT ROUTE");
    MyNavigator.pushNamed(GoPaths.dashboard, extra: payload);


  }

  fcmListener() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        print("notification received");

        createNotification(message);
      },
    );
  }

  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    try {
      final Map payLoadMap = json.decode(payload ?? "");

      onNotificationClicked(payload: payLoadMap, path: "fcmListener()");
    } catch (e) {
      print("onDidReceiveNotificationResponse error $e");
    }
  }

  //-------------------------------------------------------------------

  static void createNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const  androidNotificationDetails =  AndroidNotificationDetails(
        'pushNotification',
        'pushNotification',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
        color: AppColors.roseEbony,
      );

      const iosNotificationDetail = DarwinNotificationDetails();

      const  notificationDetails = NotificationDetails(
        iOS: iosNotificationDetail,
        android: androidNotificationDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        id,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: json.encode(message.data),
      );
    } catch (error) {
      print("Notification Create Error $error");
    }
  }
}
