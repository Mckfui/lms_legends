import 'package:flutter/material.dart';
import 'package:lsm_legends/utils/web_colors.dart';

class WebAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const WebAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const Spacer(),
          if (actions != null) ...actions!,
          const SizedBox(width: 16),
          _buildNotificationIcon(),
          const SizedBox(width: 16),
          _buildProfileDropdown(),
        ],
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: Color(0xFF64748B)),
        ),
        Positioned(
          right: 12,
          top: 12,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileDropdown() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: WebColors.primary,
          child: Icon(Icons.person, color: Colors.white, size: 20),
        ),
        Icon(Icons.arrow_drop_down, color: Color(0xFF64748B)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
