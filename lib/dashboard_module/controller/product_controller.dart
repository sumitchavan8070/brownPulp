import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/dashboard_module/models/product_model.dart';
import 'package:project/utilities/dio/api_end_points.dart';
import 'package:project/utilities/dio/api_request.dart';

class ProductController extends GetxController with StateMixin<ProductModel> {
  getProducts() async {
    final apiEndPoint = APIEndPoints.getSofasData;

    debugPrint("---------- $apiEndPoint  Start ----------");

    change(null, status: RxStatus.loading());

    try {
      final postData = {"category": "Sofas"};
      final response = await postRequest(apiEndPoint: apiEndPoint, postData: postData);

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      debugPrint("here is the api data ${response.data}");

      final modal = ProductModel.fromJson(response.data);
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
