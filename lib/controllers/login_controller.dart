
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../customs/constants.dart';
import '../main.dart';
import '../screens/home_screen.dart';
class LoginController extends GetxController{
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final obscure = true.obs;
  isObscure(){
    obscure.value=!obscure.value;
  }

  void checkLogIn(BuildContext context) async {
    final username = nameController.text;
    final password = passwordController.text;
    if (username == "Anuja" && password == "anu123") {
      final sharedprfs = await SharedPreferences.getInstance();
      await sharedprfs.setBool(saveKey, true);
      Get.snackbar(
        "Login Success","",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor:green,
        colorText:black,
        margin: const EdgeInsets.all(15.0),
        duration: const Duration(seconds: 3),
      );
     Get.off(HomePage());
    } else {
      Get.snackbar(
        "Login Failed",
        "User name or password is incorrect",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor:red,
        colorText:black,
        margin: const EdgeInsets.all(15.0),
        duration: const Duration(seconds: 3),
      );
    }
  }

}