import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project/order_module/controller/my_cart_controller.dart';
final _getMyCartController = Get.put(MyCartController());

class GlobalVars {

  static GetStorage prefs = GetStorage();

  static bool isLoggedIn = prefs.read("IS_LOGGED_IN") ?? false;

  static String? authToken = prefs.read("TOKEN");
  static String userId = prefs.read("USER_ID").toString()  ?? "7";
  static String cartCount = _getMyCartController.state?.products?.length.toString()   ?? "5";
}
