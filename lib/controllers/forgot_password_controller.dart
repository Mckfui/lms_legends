import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_legends/core/services/auth_services.dart';
import 'package:lsm_legends/global_widgets/custom_alert.dart';
import 'package:lsm_legends/utils/assets_manager.dart';

class ForgotPasswordController extends GetxController {
  final globalKey = GlobalKey<FormState>();
  RxString emailError = RxString('');
  String email = '';
  final RxBool isLoading = false.obs;

  void validateEmail(String email) {
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);

    if (regex.hasMatch(email)) {
      emailError.value = '';
    } else {
      emailError.value = 'Invalid email address';
    }
  }

  void submit() async {
    if (globalKey.currentState!.validate() && emailError.value.isEmpty) {
      isLoading.value = true;
      try {
        await AuthServices.resetPassword(email: email);
        isLoading.value = false;
        Get.dialog(
          CustomAlert(
            title: 'Email Sent',
            description: 'A password reset link has been sent to your email.',
            buttonText: 'Back to Login',
            image: AnimationManager.success,
            isAnimated: true,
            onButtonTap: () {
              Get.back(); // close dialog
              Get.back(); // navigate back to login screen
            },
          ),
          barrierDismissible: false,
        );
      } catch (e) {
        isLoading.value = false;
        Get.dialog(
          const CustomAlert(
            title: 'Error',
            description:
                'Failed to send password reset email. Please ensure the email is registered.',
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
