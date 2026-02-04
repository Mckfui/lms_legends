import 'package:flutter/material.dart';
import 'package:lsm_legends/core/responsive_layout.dart';
import 'package:lsm_legends/global_widgets/web_app_bar.dart';
import 'package:lsm_legends/global_widgets/web_sidebar.dart';
import 'package:lsm_legends/utils/web_colors.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
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
      appBar: AppBar(
        title: const Text("Admin Panel"),
        backgroundColor: WebColors.sidebarBg,
        foregroundColor: Colors.white,
      ),
      body: _buildContent(),
      drawer: Drawer(
        child: WebSidebar(
          currentIndex: _selectedIndex,
          onItemSelected: (index) {
            setState(() => _selectedIndex = index);
            Navigator.pop(context);
          },
          role: 'admin',
        ),
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
            role: 'admin',
          ),
          Expanded(
            child: Column(
              children: [
                WebAppBar(title: _getTitle()),
                Expanded(
                  child: Container(
                    color: WebColors.background,
                    padding: const EdgeInsets.all(32),
                    child: _buildContent(),
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
        return 'System Overview';
      case 1:
        return 'User Management';
      case 2:
        return 'Course Management';
      case 3:
        return 'Categories';
      case 4:
        return 'Settings';
      default:
        return 'Admin Dashboard';
    }
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          _buildStatsGrid(),
          const SizedBox(height: 32),
          _buildActivityTable(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'System Administration',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Overview of platform performance and management tools.',
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
        _buildStatCard(
          'Total Revenue',
          '\$45,280',
          Icons.payments,
          Colors.green,
        ),
        _buildStatCard('New Users', '156', Icons.person_add, Colors.blue),
        _buildStatCard(
          'Total Courses',
          '48',
          Icons.auto_stories,
          Colors.orange,
        ),
        _buildStatCard('Platform Rating', '4.9', Icons.star, Colors.amber),
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

  Widget _buildActivityTable() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: WebColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          const Divider(height: 1),
          DataTable(
            columnSpacing: 20,
            horizontalMargin: 24,
            columns: const [
              DataColumn(label: Text('Transaction ID')),
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Date')),
            ],
            rows: List.generate(
              5,
              (index) => DataRow(
                cells: [
                  DataCell(Text('#TRX-${1000 + index}')),
                  const DataCell(Text('Alex Johnson')),
                  const DataCell(Text('\$149.00')),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Success',
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    ),
                  ),
                  const DataCell(Text('Oct 12, 2023')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
