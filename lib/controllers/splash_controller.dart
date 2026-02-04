import 'dart:async';

import 'package:get/get.dart';
import 'package:lsm_legends/core/services/shared_services.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigate();
  }

  void navigate() {
    // Check user login and navigate
    Timer(const Duration(seconds: 5), SharedServices.checkLogin);
  }
}
