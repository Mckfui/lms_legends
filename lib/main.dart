import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_legends/bindings/all_bindings.dart';
import 'package:lsm_legends/controllers/auth_controller.dart';
import 'package:lsm_legends/firebase_options.dart';
import 'package:lsm_legends/routes/route_destinations.dart';
import 'package:lsm_legends/views/Admin/admin_dashboard.dart';
import 'package:lsm_legends/views/Authentication/LoginScreen/login_screen.dart';
import 'package:lsm_legends/views/Lecturer/lecturer_dashboard.dart';
import 'package:lsm_legends/views/Student/student_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Firestore Connectivity Fixes
  if (kIsWeb) {
    // Web requires specific configuration
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled:
          true, // Web often works better with this enabled or default
    );
  } else {
    // Global persistence reset (fixes local file/cache locks on Windows & Mobile)
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: false,
      sslEnabled: true,
    );
    // Forcefully enable network in case the SDK is stuck in offline mode (Only safe on non-web)
    await FirebaseFirestore.instance.enableNetwork();
  }

  final authController = Get.put(AuthController());
  await authController.loadUser(); // ✅ allowed now
  AllBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AllBindings(),
      debugShowCheckedModeBanner: false,
      getPages: Routes.destination,
      home: Obx(() {
        final user = Get.find<AuthController>().currentUser.value;
        if (user == null) {
          return const LoginScreen();
        } else if (user.role == 'admin') {
          return const AdminDashboard();
        } else if (user.role == 'lecturer') {
          return const LecturerDashboard();
        } else {
          return const StudentDashboard();
        }
      }),
    );
  }
}
