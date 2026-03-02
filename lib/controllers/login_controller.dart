import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_legends/controllers/auth_controller.dart';

import '../core/services/auth_services.dart';
import '../global_widgets/custom_alert.dart';
import '../models/user_model.dart';
import '../utils/assets_manager.dart';

class LoginController extends GetxController {
  final globalKey = GlobalKey<FormState>();
  RxString emailError = RxString('');
  final UserModel user = UserModel();
  final RxBool isLoading = false.obs;

  void validateEmail(String email) {
    // Regular expression for a simple email validation
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);

    if (regex.hasMatch(email)) {
      emailError.value = '';
    } else {
      emailError.value = 'Invalid email address';
    }
  }

  void login() async {
    if (globalKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final UserModel? loggedInUser = await AuthServices.login(user: user);
        isLoading.value = false;
        update();
        if (loggedInUser != null) {
          Get.find<AuthController>().currentUser.value = loggedInUser;
        } else {
          Get.dialog(
            const CustomAlert(
              title: 'Error!',
              description: 'Login failed! Please check your credentials.',
              buttonText: 'Try Again',
              image: AnimationManager.error,
              isAnimated: true,
            ),
            barrierDismissible: true,
          );
        }
      } catch (e) {
        isLoading.value = false;
        update();

        if (e.toString().contains('email-unverified')) {
          Get.dialog(
            CustomAlert(
              title: 'Email Not Verified',
              description:
                  'Please verify your email address to continue. Check your inbox for the verification link.',
              buttonText: 'Resend Email',
              image: AnimationManager
                  .error, // Assuming warning animation isn't available
              isAnimated: true,
              onButtonTap: () async {
                Get.back();
                try {
                  await AuthServices.sendEmailVerification();
                  Get.snackbar('Success', 'Verification email sent!');
                } catch (e) {
                  Get.snackbar('Error', 'Failed to resend email.');
                }
              },
            ),
            barrierDismissible: true,
          );
        } else {
          Get.dialog(
            const CustomAlert(
              title: 'Error!',
              description: 'Login failed! Please check your credentials.',
              buttonText: 'Try Again',
              image: AnimationManager.error,
              isAnimated: true,
            ),
            barrierDismissible: true,
          );
        }
      }
    }
  }
}
