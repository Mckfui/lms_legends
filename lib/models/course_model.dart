import 'package:lsm_legends/utils/config.dart';

class CourseModel {
  String? id;
  String title;
  String thumbnail;
  int? salePrice;
  int regularPrice;
  String author;
  int? rating;
  int? completed;
  double? completedValue;
  List<Topics>? topics;
  String promoVide;

  CourseModel({
    this.id,
    required this.title,
    required this.thumbnail,
    this.salePrice,
    required this.regularPrice,
    required this.author,
    this.rating,
    this.completed,
    this.completedValue,
    this.topics,
    required this.promoVide,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'sale_price': salePrice,
      'regular_price': regularPrice,
      'author': author,
      'rating': rating,
      'completed': completed,
      'completed_value': completedValue,
      'promo_vide': promoVide,
      'topics': topics?.map((x) => x.toMap()).toList(),
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return CourseModel(
      id: id ?? map['id'],
      title: map['title'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      salePrice: map['sale_price'],
      regularPrice: map['regular_price'] ?? 0,
      author: map['author'] ?? '',
      rating: map['rating'],
      completed: map['completed'],
      completedValue: (map['completed_value'] as num?)?.toDouble(),
      promoVide: map['promo_vide'] ?? '',
      topics: map['topics'] != null
          ? List<Topics>.from(map['topics']?.map((x) => Topics.fromMap(x)))
          : null,
    );
  }
}

class Topics {
  String title;
  String totalDuration;
  int totalLesson;
  List<Lessons>? lesson;

  Topics({
    required this.title,
    required this.totalDuration,
    required this.totalLesson,
    this.lesson,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'total_duration': totalDuration,
      'total_lesson': totalLesson,
      'lesson': lesson?.map((x) => x.toMap()).toList(),
    };
  }

  factory Topics.fromMap(Map<String, dynamic> map) {
    return Topics(
      title: map['title'] ?? '',
      totalDuration: map['total_duration'] ?? '',
      totalLesson: map['total_lesson'] ?? 0,
      lesson: map['lesson'] != null
          ? List<Lessons>.from(map['lesson']?.map((x) => Lessons.fromMap(x)))
          : null,
    );
  }
}

class Lessons {
  String title;
  String lessonUrl;
  String duration;
  bool isComplete;

  Lessons({
    required this.title,
    required this.lessonUrl,
    required this.duration,
    required this.isComplete,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'lesson_url': lessonUrl,
      'duration': duration,
      'is_complete': isComplete,
    };
  }

  factory Lessons.fromMap(Map<String, dynamic> map) {
    return Lessons(
      title: map['title'] ?? '',
      lessonUrl: map['lesson_url'] ?? '',
      duration: map['duration'] ?? '',
      isComplete: map['is_complete'] ?? false,
    );
  }
}

List<CourseModel> getFeaturedCourse = [
  CourseModel(
    promoVide: 'assets/videos/flutter.mp4',
    title: 'Mastering Entrepreneurship',
    thumbnail:
        'https://interactivecares-courses.com/wp-content/uploads/2023/07/Course-Cover-Eng-1024x536.png',
    salePrice: 2000,
    regularPrice: 1000,
    author: AppConfig.appName,
    rating: 5,
    completed: 60,
    completedValue: 0.6,
    topics: [
      Topics(
        title: 'Module 01: Introduction',
        totalDuration: '00:25:30',
        totalLesson: 2,
        lesson: [
          Lessons(
            title: 'Introduction to entrepreneurship',
            lessonUrl: 'assets/videos/flutter.mp4',
            duration: '00:06:53',
            isComplete: false,
          ),
          Lessons(
            title: 'Things you need to start a business',
            lessonUrl: 'assets/videos/seo.mp4',
            duration: '00:05:29',
            isComplete: false,
          ),
        ],
      ),
      Topics(
        title: 'Module 02: Business Plan',
        totalDuration: '00:06:35',
        totalLesson: 1,
        lesson: [
          Lessons(
            title: 'Business Outline',
            lessonUrl: 'assets/videos/flutter.mp4',
            duration: '00:06:35',
            isComplete: false,
          ),
        ],
      ),
    ],
  ),
  CourseModel(
    promoVide: 'assets/videos/seo.mp4',
    title: 'DevOps Career Path',
    thumbnail:
        'https://interactivecares-courses.com/wp-content/uploads/2023/07/DevOPS-For-Website1-1024x536.png',
    regularPrice: 12500,
    author: AppConfig.appName,
    rating: 4,
    completed: 95,
    completedValue: 0.95,
    topics: [
      Topics(
        title: 'Module 01: Version Control System (VCS)',
        totalDuration: '00:12:09',
        totalLesson: 2,
        lesson: [
          Lessons(
            title: 'Introduction to GIT',
            lessonUrl: 'assets/videos/seo.mp4',
            duration: '00:05:25',
            isComplete: false,
          ),
          Lessons(
            title: 'Installation and configuration',
            lessonUrl: 'assets/videos/flutter.mp4',
            duration: '00:06:43',
            isComplete: false,
          ),
        ],
      ),
    ],
  ),
  CourseModel(
    promoVide: 'assets/videos/flutter.mp4',
    title: 'Full Course on SEO',
    thumbnail:
        'https://interactivecares-courses.com/wp-content/uploads/2023/06/june-6-768x402.png',
    regularPrice: 2000,
    salePrice: 1000,
    author: AppConfig.appName,
    rating: 1,
    completed: 90,
    completedValue: 0.9,
  ),
  CourseModel(
    promoVide: 'assets/videos/flutter.mp4',
    title: 'Mastering Entrepreneurship',
    thumbnail:
        'https://interactivecares-courses.com/wp-content/uploads/2023/07/Course-Cover-Eng-1024x536.png',
    salePrice: 2000,
    regularPrice: 1000,
    author: AppConfig.appName,
    rating: 4,
    completed: 90,
    completedValue: 0.9,
  ),
];
