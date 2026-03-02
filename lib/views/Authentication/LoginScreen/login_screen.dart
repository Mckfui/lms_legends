import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_legends/controllers/login_controller.dart';
import 'package:lsm_legends/core/responsive_layout.dart';
import 'package:lsm_legends/global_widgets/custom_button.dart';
import 'package:lsm_legends/helpers/form_helpers.dart';
import 'package:lsm_legends/routes/route_names.dart';
import 'package:lsm_legends/utils/assets_manager.dart';
import 'package:lsm_legends/utils/themes.dart';
import 'package:lsm_legends/utils/web_colors.dart';

import '../../../utils/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: ResponsiveLayout(
        mobile: _buildMobileLogin(context, controller),
        desktop: _buildWebLogin(context, controller),
      ),
    );
  }

  Widget _buildMobileLogin(BuildContext context, LoginController controller) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 50),
                _buildForm(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebLogin(BuildContext context, LoginController controller) {
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
                  'LSM Legends',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Mastering the art of learning.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Login Form Section
        Expanded(
          flex: 1,
          child: Container(
            color: WebColors.background,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 450),
                padding: const EdgeInsets.all(40),
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
                      const SizedBox(height: 40),
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
        Image.asset(ImageManager.logo, height: 80),
        TextFormat.bold(text: 'Welcome Back!'),
        TextFormat.small(
          text: 'Login to continue',
          textColor: Colors.black.withOpacity(.5),
        ),
      ],
    );
  }

  Widget _buildForm(LoginController controller) {
    return Obx(
      () => Column(
        children: [
          Form(
            key: controller.globalKey,
            child: Column(
              children: [
                CustomTextField(
                  topLabelText: 'Your Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icons.alternate_email,
                  isRequired: true,
                  errorText: controller.emailError.value.isNotEmpty
                      ? 'Invalid Email Address'
                      : null,
                  onChanged: (email) {
                    controller.user.email = email;
                    controller.validateEmail(email);
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  topLabelText: 'Password',
                  hintText: 'Enter account password',
                  prefixIcon: Icons.password,
                  isRequired: true,
                  isSecured: true,
                  isLogin: true,
                  onChanged: (p0) => controller.user.password = p0,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => Get.toNamed(RouteNames.forgotPassword),
                child: TextFormat.small(text: 'Forget password?', opacity: 0.5),
              ),
            ],
          ),
          const SizedBox(height: 25),
          CustomButton(
            isLoading: controller.isLoading.value,
            buttonTitle: 'Log In',
            onTap: () {
              print('LoginScreen: Log In button tapped');
              controller.login();
            },
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormat.small(text: "Don't have an account?", opacity: 0.5),
              const SizedBox(width: 5),
              TextFormat.small(
                text: "Sign Up",
                textColor: AppColors.primary,
                fontWeight: FontWeight.w600,
                onTap: () => Get.toNamed(RouteNames.register),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
