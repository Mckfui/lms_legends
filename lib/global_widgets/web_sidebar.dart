import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_legends/controllers/auth_controller.dart';
import 'package:lsm_legends/routes/route_names.dart';
import 'package:lsm_legends/utils/web_colors.dart';

class WebSidebar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;
  final String role;

  const WebSidebar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: WebColors.sidebarBg,
      child: Column(
        children: [
          _buildLogo(),
          const SizedBox(height: 40),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _buildMenuItems(),
            ),
          ),
          _buildUserInfo(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: WebColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.school, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          const Text(
            'LSM Legends',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMenuItems() {
    final List<Map<String, dynamic>> items = _getRoleItems();

    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final isActive = currentIndex == index;

      return _SidebarItem(
        icon: item['icon'],
        label: item['label'],
        isActive: isActive,
        onTap: () => onItemSelected(index),
      );
    }).toList();
  }

  List<Map<String, dynamic>> _getRoleItems() {
    switch (role) {
      case 'admin':
        return [
          {'icon': Icons.dashboard, 'label': 'Dashboard'},
          {'icon': Icons.people, 'label': 'Users'},
          {'icon': Icons.book, 'label': 'Courses'},
          {'icon': Icons.category, 'label': 'Categories'},
          {'icon': Icons.settings, 'label': 'Settings'},
        ];
      case 'lecturer':
        return [
          {'icon': Icons.dashboard, 'label': 'Dashboard'},
          {'icon': Icons.library_books, 'label': 'My Courses'},
          {'icon': Icons.group, 'label': 'Students'},
          {'icon': Icons.analytics, 'label': 'Analytics'},
          {'icon': Icons.settings, 'label': 'Settings'},
        ];
      default: // student
        return [
          {'icon': Icons.home, 'label': 'Home'},
          {'icon': Icons.school, 'label': 'My Learning'},
          {'icon': Icons.bookmark, 'label': 'Bookmarks'},
          {'icon': Icons.person, 'label': 'Profile'},
          {'icon': Icons.settings, 'label': 'Settings'},
        ];
    }
  }

  Widget _buildUserInfo() {
    final authController = Get.find<AuthController>();
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: WebColors.primary,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    role.capitalizeFirst ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    authController.currentUser.value?.fullName ?? 'Demo User',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.offAllNamed(RouteNames.login);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white.withAlpha(150),
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isActive
                ? WebColors.primary.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive ? WebColors.primary : WebColors.sidebarIcon,
                size: 22,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: isActive
                      ? WebColors.sidebarActive
                      : WebColors.sidebarText,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
