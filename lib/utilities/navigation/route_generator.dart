import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/auth_module/login_module/login_view.dart';
import 'package:project/dashboard_module/notification/notification_view.dart';
import 'package:project/dashboard_module/onboarding/onboarding_view.dart';
import 'package:project/dashboard_module/view/dashboard_view.dart';
import 'package:project/dashboard_module/view/product_detail_view.dart';
import 'package:project/my_cart.dart';
import 'package:project/utilities/navigation/go_paths.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter goRouterConfig = GoRouter(
  // initialLocation: GoPaths.serOnBoardingScreen,
  initialLocation: GoPaths.loginScreen,

  navigatorKey: rootNavigatorKey,
  routes: [
    // ShellRoute(
    //   navigatorKey: shellNavigatorKey,
    //   builder: (context, state, child) {
    //     return SerchWordMean();
    //   },
    //   routes: const [
    //     // GoRoute(
    //     //   parentNavigatorKey: shellNavigatorKey,
    //     //   path: GoPaths.home,
    //     //   builder: (context, state) {
    //     //     return const HomeScreenView();
    //     //   },
    //     // ),
    //     // GoRoute(
    //     //   parentNavigatorKey: shellNavigatorKey,
    //     //   path: GoPaths.page1,
    //     //   builder: (context, state) {
    //     //     return Page1();
    //     //   },
    //     // ),
    //
    //   ],
    // ),

    // -------------------------------------- X --------------------------------------

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.dashboard,
      name: GoPaths.dashboard,
      builder: (context, state) {
        return const DashBoardView();
      },
    ),



    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.myCart,
      name: GoPaths.myCart,
      builder: (context, state) {
        return const MyCart();
      },
    ),



    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.loginScreen,
      name: GoPaths.loginScreen,
      builder: (context, state) {
        return const LoginView();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.notification,
      name: GoPaths.notification,
      builder: (context, state) {
        return const NotificationScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.onboardingQuestions,
      name: GoPaths.onboardingQuestions,
      builder: (context, state) {
        return const OnboardingQuestions();
      },
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: GoPaths.productDetailView,
      name: GoPaths.productDetailView,
      builder: (context, state) {
        // final extraParams = state.extra as Map<String, dynamic>; // Explicit casting
        // final name = extraParams['name'];
        // final image = extraParams['name'];
        return const  ProductDetailView(
          // name: name,
          // image: image,
        );
      },
    ),

    //  ---- test liked added or not ----
    // GoRoute(
    //   parentNavigatorKey: rootNavigatorKey,
    //   path: GoPaths.likedFlashCardsView,
    //   name: GoPaths.likedFlashCardsView,
    //   builder: (context, state) {
    //     final extraParams = state.extra as Map<String, dynamic>; // Explicit casting
    //     final dbName = extraParams['dbName'];
    //     final title = extraParams['title'];
    //     return LikedFlashCardsView(
    //       dbName: dbName,
    //       title: title,
    //     );
    //   },
    // ),
  ],
);
