import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lsm_legends/controllers/home_controller.dart';
import 'package:lsm_legends/core/responsive_layout.dart';
import 'package:lsm_legends/utils/colors.dart';
import 'package:lsm_legends/utils/themes.dart';

class FeaturedCourseSection extends StatelessWidget {
  const FeaturedCourseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Courses',
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
              : ResponsiveLayout(
                  mobile: _buildMobileList(controller),
                  desktop: _buildWebGrid(controller),
                ),
        ),
      ],
    );
  }

  Widget _buildMobileList(HomeController controller) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.filteredCourses.length,
        itemBuilder: (context, index) {
          final data = controller.filteredCourses[index];
          final size = MediaQuery.sizeOf(context);
          return _buildCourseCard(data, size.width * .8, 130);
        },
      ),
    );
  }

  Widget _buildWebGrid(HomeController controller) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: 140,
      ),
      itemCount: controller.filteredCourses.length,
      itemBuilder: (context, index) {
        final data = controller.filteredCourses[index];
        return _buildCourseCard(data, double.infinity, 140);
      },
    );
  }

  Widget _buildCourseCard(dynamic data, double width, double height) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black.withOpacity(.050)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth * .4,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(data.thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextFormat.extraSmall(
                            text: 'By ${data.author}',
                            opacity: .5,
                          ),
                          data.salePrice != null
                              ? Row(
                                  children: [
                                    TextFormat.small(
                                      text: '৳${data.salePrice}',
                                      textColor: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    const SizedBox(width: 10),
                                    TextFormat.small(
                                      text: '৳${data.regularPrice}',
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ],
                                )
                              : TextFormat.small(
                                  text: '৳${data.regularPrice}',
                                  textColor: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                        ],
                      ),
                      Container(
                        width: constraints.maxWidth * .5,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                size: 14,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Add to cart',
                                style: GoogleFonts.poppins(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
