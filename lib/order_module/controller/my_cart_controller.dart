import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/order_module/model/add_to_cart_model.dart';
import 'package:project/order_module/model/my_orders_model.dart';
import 'package:project/utilities/dio/api_end_points.dart';
import 'package:project/utilities/dio/api_request.dart';

class MyCartController extends GetxController with StateMixin<MyOrdersModel> {
  Future<num> getMyCart({userId}) async {
    final apiEndPoint = APIEndPoints.myCart;

    debugPrint("---------- $apiEndPoint  Start ----------");

    change(null, status: RxStatus.loading());

    try {
      final postData = {
        "userId": userId,
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
        final modal = MyOrdersModel.fromJson(response.data);
        change(modal, status: RxStatus.success());
      }
    } catch (error) {
      debugPrint("---------- $apiEndPoint  End With Error ----------");
      debugPrint("MyCartController =>  Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint  End ----------");
    }

    return state?.status ?? 0;
  }
}
