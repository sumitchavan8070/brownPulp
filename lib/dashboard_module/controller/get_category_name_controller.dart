import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/dashboard_module/models/get_category_name_model.dart';
import 'package:project/utilities/dio/api_end_points.dart';
import 'package:project/utilities/dio/api_request.dart';

class GetCategoryController extends GetxController with StateMixin<GetCategoryNameModel> {
  getCategoryName({required String category}) async {
    final apiEndPoint = APIEndPoints.getCategoryName;

    debugPrint("---------- $apiEndPoint  Start ----------");

    change(null, status: RxStatus.loading());

    try {
      final postData = {
        "category": category,
      };


      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: postData,
      );

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      debugPrint("here is the api data ${response.data}");
      if (response.data["status"] == 1) {
        final modal = GetCategoryNameModel.fromJson(response.data);
        change(modal, status: RxStatus.success());
      }
    } catch (error) {
      debugPrint("---------- $apiEndPoint  End With Error ----------");
      debugPrint("getCategories =>  Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint getProducts End ----------");
    }
  }
}
