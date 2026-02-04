import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lsm_legends/controllers/home_controller.dart';
import 'package:lsm_legends/helpers/auth_helper.dart';
import 'package:lsm_legends/utils/assets_manager.dart';
import 'package:lsm_legends/utils/themes.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: AuthHelper.getName(),
                  builder: (context, snapshot) {
                    return TextFormat.bold(
                      text: 'Hi ${snapshot.data ?? 'Shirajul'},',
                      textColor: Colors.white,
                    );
                  },
                ),
                TextFormat.small(
                  text: "Let's start learning",
                  fontWeight: FontWeight.w300,
                  textColor: Colors.white,
                ),
              ],
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: SvgPicture.asset(SvgManager.avatar),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            onChanged: (value) =>
                Get.find<HomeController>().onSearchChanged(value),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search for courses...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
