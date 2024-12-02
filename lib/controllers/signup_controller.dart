import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/login_Screen.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // Reactive variables
  var obscurePass = true.obs;

  // Form field values
  var email = ''.obs;
  var password = ''.obs;
  var fullName = ''.obs;

  void toggleObscurePass() {
    obscurePass.value = !obscurePass.value;
  }

  void signUpUser(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // Replace this with your service logic
      print("Sign-Up Details: $fullName, $email, $password");

      // Navigate to LoginScreen
      Get.off(() =>  LoginScreen());
    } else {
      Get.snackbar("Error", "Please fill all fields properly",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
