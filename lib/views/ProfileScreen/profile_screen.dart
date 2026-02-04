import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lsm_legends/controllers/auth_controller.dart';
import 'package:lsm_legends/global_widgets/custom_button.dart';
import 'package:lsm_legends/global_widgets/in_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: inAppBar('My Profile'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          final user = authController.currentUser.value;
          return Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150',
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoCard('Full Name', user?.fullName ?? 'N/A'),
              _buildInfoCard('Username', user?.username ?? 'N/A'),
              _buildInfoCard('Email', user?.email ?? 'N/A'),
              _buildInfoCard('Role', user?.role ?? 'student'),
              const Spacer(),
              CustomButton(
                buttonTitle: 'Logout',
                onTap: () {
                  // Implement logout logic here
                  Get.offAllNamed('/login');
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
        ),
        subtitle: Text(
          value,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.edit, size: 18),
      ),
    );
  }
}
