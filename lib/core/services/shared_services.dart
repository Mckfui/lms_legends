import 'package:get/get.dart';
import 'package:lsm_legends/helpers/auth_helper.dart';
import 'package:lsm_legends/routes/route_names.dart';

class SharedServices {
  static Future checkLogin() async {
    final token = await AuthHelper.getToken();

    // Check if logged in
    if (token != null) {
      Get.offAllNamed(RouteNames.home);
    } else {
      Get.offAllNamed(RouteNames.getStarted);
    }
  }

  static Future logout() async {
    AuthHelper.removeToken();
    Get.offAllNamed(RouteNames.login);
  }
}
