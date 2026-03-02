import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_legends/controllers/forgot_password_controller.dart';
import 'package:lsm_legends/core/responsive_layout.dart';
import 'package:lsm_legends/global_widgets/custom_button.dart';
import 'package:lsm_legends/helpers/form_helpers.dart';
import 'package:lsm_legends/utils/assets_manager.dart';
import 'package:lsm_legends/utils/themes.dart';
import 'package:lsm_legends/utils/web_colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      body: ResponsiveLayout(
        mobile: _buildMobileView(context, controller),
        desktop: _buildWebView(context, controller),
      ),
    );
  }

  Widget _buildMobileView(
    BuildContext context,
    ForgotPasswordController controller,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            Expanded(
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
          ],
        ),
      ),
    );
  }

  Widget _buildWebView(
    BuildContext context,
    ForgotPasswordController controller,
  ) {
    return Row(
      children: [
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
                  'Recover your account.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: WebColors.background,
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                  left: 40,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back, size: 30),
                  ),
                ),
                Center(
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
              ],
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
        const SizedBox(height: 15),
        TextFormat.bold(text: 'Forgot Password'),
        const SizedBox(height: 5),
        TextFormat.small(
          text: 'Enter your email to receive a password reset link',
          textColor: Colors.black.withOpacity(.5),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildForm(ForgotPasswordController controller) {
    return Obx(
      () => Column(
        children: [
          Form(
            key: controller.globalKey,
            child: CustomTextField(
              topLabelText: 'Your Email',
              hintText: 'Enter your email',
              prefixIcon: Icons.alternate_email,
              isRequired: true,
              errorText: controller.emailError.value.isNotEmpty
                  ? 'Invalid Email Address'
                  : null,
              onChanged: (email) {
                controller.email = email;
                controller.validateEmail(email);
              },
            ),
          ),
          const SizedBox(height: 35),
          CustomButton(
            isLoading: controller.isLoading.value,
            buttonTitle: 'Send Reset Link',
            onTap: () {
              controller.submit();
            },
          ),
        ],
      ),
    );
  }
}
