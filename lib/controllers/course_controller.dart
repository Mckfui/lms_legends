import 'package:get/get.dart';
import 'package:lsm_legends/global_widgets/custom_alert.dart';
import 'package:lsm_legends/routes/route_names.dart';
import 'package:lsm_legends/utils/assets_manager.dart';

import '../models/course_model.dart';

class CourseController extends GetxController {
  final featuredCourses = <CourseModel>[].obs;

  RxInt expandedTileIndex = RxInt(-1);

  RxInt currentLessonIndex = RxInt(0);
  RxBool isTheaterMode = false.obs;

  RxDouble overallCourseProgress = 0.0.obs;

  // Function to handle expansion state
  void handleExpansion(int index) {
    // Update the expandedTileIndex
    expandedTileIndex.value = index;
    update();
    expandedTileIndex.refresh();
  }

  void nextLesson(List<Lessons>? lessons) {
    if (currentLessonIndex.value < lessons!.length - 1) {
      currentLessonIndex.value++;
      update();
    }
  }

  void previousLesson() {
    if (currentLessonIndex.value > 0) {
      currentLessonIndex.value--;
      update();
    }
  }

  void completeLesson(List<Lessons>? lessons, CourseModel course) {
    lessons![currentLessonIndex.value].isComplete = true;
    update();

    // Check if all lessons are completed
    if (allLessonsCompleted(lessons, course.topics)) {
      Get.dialog(
        CustomAlert(
          title: 'Congratulations!',
          description:
              'You have completed "${course.title}" course successfully',
          buttonText: 'Claim Certificate',
          image: AnimationManager.success,
          isAnimated: true,
          onButtonTap: () => Get.offAllNamed(RouteNames.home),
        ),
        barrierDismissible: false,
      );
    }
  }

  bool allLessonsCompleted(List<Lessons>? lessons, List<Topics>? topics) {
    return topics!.every(
      (topic) => topic.lesson!.every((lesson) => lesson.isComplete),
    );
  }

  double calculateOverallCourseProgress(CourseModel course) {
    if (course.topics == null || course.topics!.isEmpty) {
      return 0.0;
    }

    int totalLessons = 0;
    int completedLessons = 0;

    for (var topic in course.topics!) {
      if (topic.lesson != null) {
        totalLessons += topic.lesson!.length;
        completedLessons += topic.lesson!
            .where((lesson) => lesson.isComplete)
            .length;
      }
    }

    final progress = totalLessons > 0 ? completedLessons / totalLessons : 0.0;
    overallCourseProgress.value = progress;
    return progress;
  }
}
