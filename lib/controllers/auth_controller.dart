import 'dart:convert';

import 'package:get/get.dart';
import 'package:lsm_legends/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var currentUser = Rxn<UserModel>();

  // No manual login method here anymore - LoginController handles it via AuthServices

  Future<void> loadUser() async {
    final pref = await SharedPreferences.getInstance();
    final userJson = pref.getString('user');
    if (userJson != null) {
      currentUser.value = UserModel.fromJson(jsonDecode(userJson));
    }
  }

  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('user');
    currentUser.value = null;
  }
}
