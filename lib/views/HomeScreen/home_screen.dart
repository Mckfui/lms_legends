import 'package:flutter/material.dart';
import 'package:lsm_legends/core/responsive_layout.dart';
import 'package:lsm_legends/views/HomeScreen/widgets/category_section.dart';
import 'package:lsm_legends/views/HomeScreen/widgets/featured_course_section.dart';
import 'package:lsm_legends/views/HomeScreen/widgets/home_app_bar.dart';
import 'package:lsm_legends/views/HomeScreen/widgets/leatest_courses_section.dart';
import 'package:lsm_legends/views/HomeScreen/widgets/slider_section.dart';

import '../../utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: _buildMobileHome(context),
        desktop: _buildWebHome(context),
      ),
    );
  }

  Widget _buildMobileHome(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * .22,
              decoration: BoxDecoration(color: AppColors.primary),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeAppBar(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                      children: [
                        SliderSection(),
                        CategorySection(),
                        FeaturedCourseSection(),
                        LatestCoursesSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebHome(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
              child: const HomeAppBar(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Column(
                children: [
                  SliderSection(),
                  SizedBox(height: 40),
                  CategorySection(),
                  SizedBox(height: 40),
                  FeaturedCourseSection(),
                  SizedBox(height: 40),
                  LatestCoursesSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
