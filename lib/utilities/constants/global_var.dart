import 'package:get_storage/get_storage.dart';

class GlobalVars {
  static GetStorage prefs = GetStorage();

  static bool isLoggedIn = prefs.read("IS_LOGGED_IN") ?? false;

  static String? authToken = prefs.read("TOKEN");
  static String userId = prefs.read("USER_ID").toString()  ?? "7";
}
