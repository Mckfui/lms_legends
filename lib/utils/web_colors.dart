import 'package:flutter/material.dart';

class WebColors {
  static const Color primary = Color(0xFF18b3c7);
  static const Color secondary = Color(0xFF2E3A59);
  static const Color accent = Color(0xFFFFA726);
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Colors.white;
  static const Color sidebarBg = Color(0xFF1E293B);
  static const Color sidebarText = Colors.white70;
  static const Color sidebarActive = Colors.white;
  static const Color sidebarIcon = Colors.white60;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF18b3c7), Color(0xFF1392A3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const List<BoxShadow> softShadow = [
    BoxShadow(color: Color(0x0F000000), offset: Offset(0, 4), blurRadius: 12),
  ];
}
