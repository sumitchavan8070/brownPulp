import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicLinkService {
  Future<void> initDynamicLinkService() async {
    try {
      final PendingDynamicLinkData? instance = await FirebaseDynamicLinks.instance.getInitialLink();

      if (instance != null) {
        handleDynamicLinkData(instance);
      }
    } catch (e) {
      print("Dynamic link initialization error: $e");
    }

    await dynamicLinkListener(); // Make sure to await the dynamicLinkListener
  }

  Future<String> dynamicLinkListener() async {
    try {
      final link = FirebaseDynamicLinks.instance;

      link.onLink.listen((dynamicLinkData) async {
        final Uri deepLink = dynamicLinkData.link;
        debugPrint("Received dynamic link: deepLink $deepLink");

        final Map<String, dynamic> queryParameters = deepLink.queryParameters;
        handleDynamicLinkClick(queryParameters: queryParameters);
      }).onError((error) {
        debugPrint("Error receiving dynamic link: $error");
      });

      String url = "https://instantassignmenthelp.page.link/Login";

      final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
        androidParameters: const AndroidParameters(
          packageName: "com.instantassignmenthelp",
          minimumVersion: 0,
        ),
        link: Uri.parse(url),
        uriPrefix: 'https://instantassignmenthelp.page.link',
      );

      final ShortDynamicLink shortLink = await link.buildShortLink(dynamicLinkParameters);

      debugPrint("dynamic link : ${shortLink.shortUrl}  Link Preview : ${shortLink.previewLink}");
      return shortLink.shortUrl.toString();
    } catch (e) {
      debugPrint("Error in dynamicLinkListener: $e");
      return ''; // Handle error appropriately
    }
  }

  void handleDynamicLinkData(PendingDynamicLinkData dynamicLinkData) {
    final Uri deepLink = dynamicLinkData.link;
    debugPrint("Received dynamic link: deepLink $deepLink");

    final Map<String, dynamic> queryParameters = deepLink.queryParameters;
    handleDynamicLinkClick(queryParameters: queryParameters);
  }
}

void handleDynamicLinkClick({required Map<String, dynamic> queryParameters}) {
  debugPrint("Handling dynamic link: $queryParameters");

  if (queryParameters.containsKey('route')) {
    Get.toNamed(queryParameters["route"]);
  }
}
