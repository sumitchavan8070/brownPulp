import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project/auth_module/login_module/login_model.dart';
import 'package:project/utilities/dio/api_end_points.dart';
import 'package:project/utilities/dio/api_request.dart';

class LoginController extends GetxController with StateMixin<LoginModel> {

  Future<num> login({required String email, required String password}) async {
    final prefs = GetStorage();

    final apiEndPoint = APIEndPoints.login;

    debugPrint("---------- $apiEndPoint  Start ----------");

    change(null, status: RxStatus.loading());

    try {
      final postData = {
        "email": email,
        "password": password,
      };
      final response = await postRequest(
        apiEndPoint: apiEndPoint,
        postData: postData,
      );

      if (response.statusCode != 200) {
        throw 'API ERROR ${response.statusCode} Message ${response.statusMessage}';
      }

      debugPrint("here is the api data ${response.data}");
      debugPrint("status is ${response.data["status"]}");

      if (response.data["status"] == 1) {

        prefs.write("IS_LOGGED_IN", true);
        prefs.write("USER_ID", response.data['id']);
        prefs.write('TOKEN', response.data['token']);

        final modal = LoginModel.fromJson(response.data);
        change(modal, status: RxStatus.success());
      }
    } catch (error) {
      debugPrint("---------- $apiEndPoint  End With Error ----------");
      debugPrint("login  Error $error ");
      change(null, status: RxStatus.error());
    } finally {
      debugPrint("---------- $apiEndPoint  End ----------");
    }

    return state?.status ?? 0;
  }
}
