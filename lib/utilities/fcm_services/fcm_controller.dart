// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:project/utilities/constants/global_var.dart';
//
// class FcmTokenController extends GetxController with StateMixin<FcmModel> {
//   final _api = FcmRepository();
//
//   fcmTokenApi(String? fcmToken) async {
//
//     Map data = {
//       'loginId':GlobalVars.userId.toString(),
//       'fcm_token': fcmToken.toString(),
//     };
//
//     _api.fcmTokenApi(data).then((value) {
//       change(value, status: RxStatus.success());
//       debugPrint("Fcm Token added successfully  ");
//     }).onError((error, stackTrace) {
//       debugPrint("here is the api error cartDetailApi  :: $error");
//       change(null, status: RxStatus.error());
//     });
//   }
// }
