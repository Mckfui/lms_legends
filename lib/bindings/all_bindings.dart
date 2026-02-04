import 'package:get/get.dart';
import 'package:lsm_legends/controllers/bottom_bar_controller.dart';
import 'package:lsm_legends/controllers/course_controller.dart';
import 'package:lsm_legends/controllers/home_controller.dart';
import 'package:lsm_legends/controllers/login_controller.dart';
import 'package:lsm_legends/controllers/register_controller.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomBarController());
    Get.lazyPut(() => CourseController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
  }
}
