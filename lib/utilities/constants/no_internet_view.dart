// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:g_a_h_app/utilities/navigation/go_paths.dart';
// import 'package:g_a_h_app/utilities/navigation/my_navigator.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
//
// class NoInternetView extends StatefulWidget {
//   const NoInternetView({Key? key}) : super(key: key);
//
//   @override
//   State<NoInternetView> createState() => _NoInternetViewState();
// }
//
// class _NoInternetViewState extends State<NoInternetView> {
//   late StreamSubscription subscription;
//
//   Future<bool> _onPop() async {
//     return false;
//   }
//
//   getConnectivity() {
//     final internetChecker = InternetConnectionCheckerPlus.createInstance(checkTimeout: const Duration(seconds: 10), checkInterval: const Duration(seconds: 5));
//     return subscription  = internetChecker.onStatusChange.listen((status) {
//       switch (status) {
//         case InternetConnectionStatus.connected:
//           if (ModalRoute
//               .of(context)
//               ?.settings
//               .name == GoPaths.noInternet) {
//             clientChangeDataReload(loadNonEssentials: true);
//             MyNavigator.pop();
//           }
//           break;
//         case InternetConnectionStatus.disconnected:
//           if (ModalRoute
//               .of(context)
//               ?.settings
//               .name != RoutePaths.noInternet) {
//             MyNavigator.pushNamed(GoPaths.noInternet);
//           }
//           break;
//       }
//     });
//
//   }
//
//   @override
//   void initState() {
//     getConnectivity();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     subscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => _onPop(),
//       child: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             fit: BoxFit.fill,
//             image: AssetImage(getBackgroundImage()),
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Lottie.asset('assets/lottieFiles/noInternet.json')
//                 .w(200)
//                 .centered(),
//           ],
//         ).h(100.h),
//       ),
//     );
//   }
// }
