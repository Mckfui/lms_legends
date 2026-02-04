import 'package:get/get.dart';
import 'package:lsm_legends/routes/route_names.dart';
import 'package:lsm_legends/views/Authentication/LoginScreen/login_screen.dart';
import 'package:lsm_legends/views/Authentication/RegisterScreen/register_screen.dart';
import 'package:lsm_legends/views/BookmarkScreen/bookmark_view_screen.dart';
import 'package:lsm_legends/views/BottomBarView/bottom_bar_view.dart';
import 'package:lsm_legends/views/GetStartedScreen/get_started_screen.dart';
import 'package:lsm_legends/views/LearningScreen/lesson_screen.dart';
import 'package:lsm_legends/views/ProfileScreen/profile_screen.dart';
import 'package:lsm_legends/views/SettingsScreen/settings_screen.dart';
import 'package:lsm_legends/views/SplashScreen/splash_screen.dart';

import '../views/LearningScreen/learning_screen.dart';

class Routes {
  static List<GetPage> destination = [
    GetPage(name: RouteNames.initial, page: () => const SplashScreen()),
    GetPage(name: RouteNames.getStarted, page: () => const GetStartedScreen()),
    GetPage(name: RouteNames.login, page: () => const LoginScreen()),
    GetPage(name: RouteNames.register, page: () => const RegisterScreen()),
    GetPage(name: RouteNames.home, page: () => const BottomBarView()),
    GetPage(name: RouteNames.courseLearn, page: () => const LearningScreen()),
    GetPage(name: RouteNames.lesson, page: () => const LessonScreen()),
    GetPage(
      name: RouteNames.bookmarkPlayer,
      page: () => const BookmarkPlayerScreen(),
    ),
    GetPage(name: RouteNames.profile, page: () => const ProfileScreen()),
    GetPage(name: RouteNames.settings, page: () => const SettingsScreen()),
  ];
}
