import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lsm_legends/models/course_model.dart';

class CourseServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Stream<List<CourseModel>> getFeaturedCourses() {
    return _firestore
        .collection('courses')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CourseModel.fromMap(doc.data(), id: doc.id))
              .toList(),
        );
  }

  static Future<void> seedInitialData() async {
    try {
      // Only seed if empty
      final snapshot = await _firestore
          .collection('courses')
          .limit(1)
          .get()
          .timeout(const Duration(seconds: 15));
      if (snapshot.docs.isNotEmpty) return;

      for (var course in getFeaturedCourse) {
        await _firestore.collection('courses').add(course.toMap());
      }
    } catch (e) {
      print('Firestore Seed Error: $e');
    }
  }
}
