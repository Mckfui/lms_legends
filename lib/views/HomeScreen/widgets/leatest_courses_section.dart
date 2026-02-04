import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lsm_legends/controllers/home_controller.dart';
import 'package:lsm_legends/core/responsive_layout.dart';
import 'package:lsm_legends/utils/themes.dart';

import '../../../utils/colors.dart';

class LatestCoursesSection extends StatelessWidget {
  const LatestCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest Courses',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            Text(
              'View All',
              style: GoogleFonts.poppins(color: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Obx(
          () =>
              controller.filteredCourses.isEmpty &&
                  controller.searchQuery.isNotEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('No courses found matching your search.'),
                  ),
                )
              : AlignedGridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: isDesktop ? 4 : 2,
                  itemCount: controller.filteredCourses.length,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  itemBuilder: (ctx, index) {
                    final data = controller.filteredCourses[index];
                    return SizedBox(
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0.1,
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/logo.webp',
                                    image: data.thumbnail,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 42,
                                    child: TextFormat.small(
                                      text: data.title,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  data.salePrice != null
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextFormat.small(
                                              text: '৳${data.salePrice}',
                                              textColor: AppColors.primary,
                                              fontWeight: FontWeight.w800,
                                            ),
                                            TextFormat.small(
                                              text: '৳${data.regularPrice}',
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ],
                                        )
                                      : TextFormat.small(
                                          text: '৳${data.regularPrice}',
                                          textColor: AppColors.primary,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.primary,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 8,
                                        ),
                                        child: Text("Buy Now"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
