import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api_client.dart';

Future<Response> getRequest({required String apiEndPoint}) async {
  try {
    Dio client = NewClient().init();

    debugPrint("^^^^^^^^^^^^^^^^^^ $apiEndPoint getRequest Start ^^^^^^^^^^^^^^^^^^");

    final response = await client.get(apiEndPoint);

    debugPrint("^^^^^^^^^^^^^^^^^^ $apiEndPoint getRequest End ^^^^^^^^^^^^^^^^^^");

    if (response.statusCode != 200) {
      throw Exception('Failed to load data: ${response.statusCode}');
    }

    return response;
  } catch (error) {
    debugPrint("get request error $error ");

    rethrow;
  }
}




Future<Response> postRequest({
  required String apiEndPoint,
  required Map<String, dynamic> postData,
}) async {
  try {
    Dio client = NewClient().init();


    debugPrint("^^^^^^^^^^^^^^^^^^ $apiEndPoint postRequest Start ^^^^^^^^^^^^^^^^^^");
    debugPrint("^^^^^^^^^^^^^^^^^^ $apiEndPoint postData $postData  ^^^^^^^^^^^^^^^^^^");

    final response = await client.post(
      apiEndPoint,
      data: postData,
      options: Options(
        contentType: Headers.jsonContentType,
      ),
    );

    debugPrint("^^^^^^^^^^^^^^^^^^ $apiEndPoint postRequest End ^^^^^^^^^^^^^^^^^^");

    if (response.statusCode != 200) {
      throw Exception('Failed to load data: ${response.statusCode}');
    }


    return response;
  } catch (error) {
    debugPrint("get request error $error ");

    rethrow;
  }

}
