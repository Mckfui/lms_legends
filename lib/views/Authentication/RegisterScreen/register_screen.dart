import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_legends/controllers/register_controller.dart';
import 'package:lsm_legends/core/responsive_layout.dart';
import 'package:lsm_legends/global_widgets/custom_button.dart';
import 'package:lsm_legends/helpers/form_helpers.dart';
import 'package:lsm_legends/routes/route_names.dart';
import 'package:lsm_legends/utils/assets_manager.dart';
import 'package:lsm_legends/utils/themes.dart';
import 'package:lsm_legends/utils/web_colors.dart';

import '../../../utils/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Scaffold(
      body: ResponsiveLayout(
        mobile: _buildMobileRegister(context, controller),
        desktop: _buildWebRegister(context, controller),
      ),
    );
  }

  Widget _buildMobileRegister(
    BuildContext context,
    RegisterController controller,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 30),
                _buildForm(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebRegister(
    BuildContext context,
    RegisterController controller,
  ) {
    return Row(
      children: [
        // Brand Section
        Expanded(
          flex: 1,
          child: Container(
            color: WebColors.sidebarBg,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImageManager.logo, height: 120),
                const SizedBox(height: 24),
                const Text(
                  'Join LSM Legends',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Start your mastery journey today.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Register Form Section
        Expanded(
          flex: 1,
          child: Container(
            color: WebColors.background,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: WebColors.softShadow,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 30),
                      _buildForm(controller),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        TextFormat.bold(text: 'Register Now!'),
        TextFormat.small(
          text: 'Fill the details below',
          textColor: Colors.black.withOpacity(.5),
        ),
      ],
    );
  }

  Widget _buildForm(RegisterController controller) {
    return Obx(
      () => Column(
        children: [
          Form(
            key: controller.globalKey,
            child: Column(
              children: [
                CustomTextField(
                  topLabelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: Icons.person_rounded,
                  isRequired: true,
                  onChanged: (p0) => controller.user.fullName = p0,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  topLabelText: 'Username',
                  hintText: 'Enter your username',
                  prefixIcon: Icons.alternate_email,
                  isRequired: true,
                  onChanged: (p0) => controller.user.username = p0,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  topLabelText: 'Your Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email_rounded,
                  isRequired: true,
                  errorText: controller.emailError.value.isNotEmpty
                      ? controller.emailError.value
                      : null,
                  onChanged: (username) {
                    controller.user.email = username;
                    controller.validateEmail(username);
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  topLabelText: 'Password',
                  hintText: 'Enter account password',
                  prefixIcon: Icons.password,
                  isRequired: true,
                  isSecured: true,
                  onChanged: (p0) => controller.user.password = p0,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  topLabelText: 'Confirm Password',
                  hintText: 'Re-type your password',
                  prefixIcon: Icons.password,
                  isRequired: true,
                  isSecured: true,
                  errorText: controller.confirmPasswordError.value.isNotEmpty
                      ? 'Password mismatched'
                      : null,
                  onChanged: (p0) {
                    controller.validateConfirmPassword(p0);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          CustomButton(
            isLoading: controller.isLoading.value,
            buttonTitle: 'Sign Up',
            onTap: () {
              if (controller.globalKey.currentState!.validate()) {
                if (controller.emailError.value.isEmpty &&
                    controller.confirmPasswordError.value.isEmpty) {
                  controller.register();
                }
              }
            },
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormat.small(text: "Already have an account?", opacity: 0.5),
              const SizedBox(width: 5),
              TextFormat.small(
                text: "Log In",
                textColor: AppColors.primary,
                fontWeight: FontWeight.w600,
                onTap: () => Get.toNamed(RouteNames.login),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
