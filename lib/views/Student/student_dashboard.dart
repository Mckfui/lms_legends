import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_legends/controllers/auth_controller.dart';
import 'package:lsm_legends/core/responsive_layout.dart';
import 'package:lsm_legends/global_widgets/web_app_bar.dart';
import 'package:lsm_legends/global_widgets/web_sidebar.dart';
import 'package:lsm_legends/utils/web_colors.dart';
import 'package:lsm_legends/views/BookmarkScreen/bookmark_screen.dart';
import 'package:lsm_legends/views/HomeScreen/home_screen.dart';
import 'package:lsm_legends/views/MyCoursesScreen/my_courses_screen.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileLayout(),
      desktop: _buildWebLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      body: _getScreen(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex > 2 ? 0 : _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'My Courses',
          ),
        ],
      ),
    );
  }

  Widget _buildWebLayout() {
    return Scaffold(
      body: Row(
        children: [
          WebSidebar(
            currentIndex: _selectedIndex,
            onItemSelected: (index) => setState(() => _selectedIndex = index),
            role: 'student',
          ),
          Expanded(
            child: Column(
              children: [
                WebAppBar(title: _getTitle()),
                Expanded(
                  child: Container(
                    color: WebColors.background,
                    padding: _selectedIndex >= 5
                        ? const EdgeInsets.all(32)
                        : EdgeInsets.zero,
                    child: _getScreen(_selectedIndex),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Bookmarks';
      case 2:
        return 'My Learning';
      case 3:
        return 'Profile';
      case 4:
        return 'Settings';
      default:
        return 'Student Dashboard';
    }
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const BookmarkScreen();
      case 2:
        return const MyCoursesScreen();
      default:
        return _buildDefaultDashboard();
    }
  }

  Widget _buildDefaultDashboard() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildStatsGrid(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final user = Get.find<AuthController>().currentUser.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Overview, ${user?.fullName ?? "Student"}! 👋',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Manage your personal settings and profile information.',
          style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: ResponsiveLayout.isDesktop(context) ? 4 : 2,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard('Enrolled Courses', '12', Icons.book, Colors.blue),
        _buildStatCard('Completed', '5', Icons.check_circle, Colors.green),
        _buildStatCard('Hours Spent', '48h', Icons.timer, Colors.orange),
        _buildStatCard(
          'Certificates',
          '2',
          Icons.card_membership,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: WebColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
              ),
              Icon(icon, color: color, size: 24),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }
}
