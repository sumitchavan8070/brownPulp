import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project/utilities/dio/api_end_points.dart';

import 'utilities/fcm_services/firebaseNotificationService.dart';
import 'utilities/navigation/route_generator.dart';
import 'utilities/theme/app_colors.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('Error: ${details.exception}');
    debugPrint('Stack trace:\n${details.stack}');
  };

  await FCMNotificationService().initNotification();

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    try {
      final Map payload = message.data;
      FCMNotificationService().onNotificationClicked(
        payload: payload,
        path: "main",
      );
    } catch (e) {
      debugPrint("onDidReceiveNotificationResponse error $e");
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // FCMNotificationService().fcmListener();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: goRouterConfig,
      debugShowCheckedModeBanner: APIEndPoints.base == APIEndPoints.staging,
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'CabinetGrotesk',
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.scienceBlue,
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20.0,
            ),
            borderSide: const BorderSide(
              color: AppColors.scienceBlue,
            ),
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
    );
  }
}
