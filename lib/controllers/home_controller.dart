import 'package:get/get.dart';
import 'package:lsm_legends/core/services/course_services.dart';
import 'package:lsm_legends/models/category_model.dart';
import 'package:lsm_legends/models/course_model.dart';

class HomeController extends GetxController {
  final categories = getCategories;
  final featuredCourses = <CourseModel>[].obs;
  final filteredCourses = <CourseModel>[].obs;
  final isLoading = true.obs;
  RxInt selectedSliderIndex = RxInt(0);
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();

    // Listen to featuredCourses and update filteredCourses
    ever(featuredCourses, (list) {
      if (searchQuery.isEmpty) {
        filteredCourses.assignAll(list);
      }
    });

    // Debounce search logic
    debounce(searchQuery, (query) {
      if (query.isEmpty) {
        filteredCourses.assignAll(featuredCourses);
      } else {
        filteredCourses.assignAll(
          featuredCourses
              .where(
                (course) =>
                    course.title.toLowerCase().contains(query.toLowerCase()) ||
                    course.author.toLowerCase().contains(query.toLowerCase()),
              )
              .toList(),
        );
      }
    }, time: const Duration(milliseconds: 500));
  }

  void fetchCourses() async {
    isLoading.value = true;
    await CourseServices.seedInitialData();
    featuredCourses.bindStream(CourseServices.getFeaturedCourses());
    featuredCourses.listen((_) {
      isLoading.value = false;
    });
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  void changeSliderIndex(int index) {
    selectedSliderIndex.value = index;
    update();
  }
}
