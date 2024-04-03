import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/order_module/model/product_detail_model.dart';
import 'package:project/utilities/dio/api_end_points.dart';
import 'package:project/utilities/dio/api_request.dart';

class   ProductDetailController extends GetxController with StateMixin<ProductDetailModel> {


  getProductDetail({required int id}) async {
    final apiEndPoint = APIEndPoints.productDetail;

    debugPrint("---------- $apiEndPoint  Start ----------");

    change(null, status: RxStatus.loading());

    try {
      final postData = {
        "id": id,
      };
      final response = await postRequest(apiEndPoint: apiEndPoint, postData: postData);

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      debugPrint("here is the api data ${response.data}");

      final modal = ProductDetailModel.fromJson(response.data);
      change(modal, status: RxStatus.success());
    } catch (error) {
      debugPrint("---------- $apiEndPoint  End With Error ----------");
      debugPrint("getProductDetail =>  Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint  End ----------");
    }
  }
}
