import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/utilities/dio/api_end_points.dart';
import 'package:project/utilities/dio/api_request.dart';

import 'notification_model.dart';



class NotificationController extends GetxController with StateMixin<NotiFicationModel2> {
  final emailController = TextEditingController().obs;
  final passController = TextEditingController().obs;
  RxString isLoggedIn = 'Login'.obs;
  RxBool isLoading = false.obs;


  notificationApi() async {
    final apiEndPoint = APIEndPoints.notification;

    debugPrint("---------- $apiEndPoint login Start ----------");

    change(null, status: RxStatus.loading());

    try {


      final response = await getRequest(
        apiEndPoint: apiEndPoint,
      );

      debugPrint("response.data status : ${response.data}");

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      final modal = NotiFicationModel2.fromJson(response.data);
      change(modal, status: RxStatus.success());

    } catch (error) {
      debugPrint("---------- $apiEndPoint  End With Error ----------");
      debugPrint("getNotificationData  => Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      isLoading.value = false;
      debugPrint("---------- $apiEndPoint  End ----------");
    }
  }
}
