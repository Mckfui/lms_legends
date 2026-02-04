import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:lsm_legends/controllers/splash_controller.dart';
import 'package:lsm_legends/utils/assets_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(body: Center(child: Lottie.asset(AnimationManager.splash)));
  }
}
