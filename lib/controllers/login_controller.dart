import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
  var obscurePass = true.obs;
  void toggleObscurePass() {
    obscurePass.value = !obscurePass.value;
  }
  Future<void> login() async {
    isLoading.value = true;
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {

      Get.snackbar('Error', 'Please enter email and password',
          snackPosition: SnackPosition.BOTTOM);
      isLoading.value = false;
      return;
    }

    try {
     await Future.delayed(Duration(seconds: 2));
     Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Login failed: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
