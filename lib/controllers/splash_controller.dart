import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

class SplashController extends GetxController {
  static const saveKey = "isLoggedIn";

  @override
  void onInit() {
    checkUserLoggedIn();
    super.onInit();
  }

  Future<void> checkUserLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPrefs.getBool(saveKey);
    print(userLoggedIn);
    await Future.delayed(const Duration(seconds: 3)); // Splash delay
    if ( userLoggedIn == false) {
     goToLogin();
    } else {
      Get.off(() => const HomePage());
    }
  }
  Future<void> goToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.off(() =>  LoginScreen());
  }
}
