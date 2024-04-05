import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/order_module/model/my_orders_model.dart';
import 'package:project/order_module/model/remove_from_my_cart_model.dart';
import 'package:project/utilities/constants/global_var.dart';
import 'package:project/utilities/dio/api_end_points.dart';
import 'package:project/utilities/dio/api_request.dart';

class RemoveFromMyCartController extends GetxController with StateMixin<RemoveFromMyCartModel> {
  Future<num> removeFromMyCart({productId}) async {
    final apiEndPoint = APIEndPoints.removeFromMyCart;

    debugPrint("---------- $apiEndPoint  Start ----------");

    change(null, status: RxStatus.loading());

    try {
      final postData = {
        "userId": GlobalVars.userId.toString(),
        "productId": productId,
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
        final modal = RemoveFromMyCartModel.fromJson(response.data);
        change(modal, status: RxStatus.success());
      }
    } catch (error) {
      debugPrint("---------- $apiEndPoint  End With Error ----------");
      debugPrint("RemoveFromMyCartController =>  Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint  End ----------");
    }

    return state?.status ?? 0;
  }
}
