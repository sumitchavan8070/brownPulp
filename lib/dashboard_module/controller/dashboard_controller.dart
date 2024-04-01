import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/dashboard_module/models/dashboard_model.dart';
import 'package:project/dashboard_module/models/product_model.dart';
import 'package:project/utilities/dio/api_end_points.dart';
import 'package:project/utilities/dio/api_request.dart';

class DashBoardController extends GetxController with StateMixin<DashBoardModel> {


  dashboard() async {
    final apiEndPoint = APIEndPoints.dashboard;

    debugPrint("---------- $apiEndPoint  Start ----------");

    change(null, status: RxStatus.loading());

    try {
      final response = await getRequest(
        apiEndPoint: apiEndPoint,
      );

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      debugPrint("here is the api data ${response.data}");

      final modal = DashBoardModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint  End With Error ----------");
      debugPrint("getProducts =>  Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getProducts End ----------");
    }
  }
}
