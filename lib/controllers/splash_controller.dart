
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registrationapp/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login_Screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkUserLoggedIn();
  }

  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulated delay
    // Add your initialization logic here (e.g., API calls, local storage)
  }
  // Check login state and navigate accordingly
  Future<void> checkUserLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = sharedPrefs.getBool('isLoggedIn');

    // Wait for splash screen duration
    await Future.delayed(const Duration(seconds: 3));

    if (isLoggedIn == null || isLoggedIn == false) {
      Get.off(() =>  LoginScreen());
    } else {
      Get.off(() =>  HomeScreen());
    }
  }
}