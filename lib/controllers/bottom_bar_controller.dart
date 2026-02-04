import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_legends/views/BookmarkScreen/bookmark_screen.dart';
import 'package:lsm_legends/views/HomeScreen/home_screen.dart';
import 'package:lsm_legends/views/MyCoursesScreen/my_courses_screen.dart';

class BottomBarController extends GetxController {
  List<Widget> screens = [
    const HomeScreen(),
    const BookmarkScreen(),
    const MyCoursesScreen(),
  ];

  RxInt currentIndex = RxInt(0);

  void changeIndex(int index) {
    currentIndex.value = index;
    update();
    currentIndex.refresh();
  }
}
