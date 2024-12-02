import 'package:flutter/material.dart';

import '../screens/login_Screen.dart';
import '../services/auth_service.dart';

class SignUpProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name cannot be empty";
    }
    if (value.length < 3) {
      return "Name must be at least 3 characters";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }


  void saveForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // checkLogIn(context);
      formKey.currentState!.save();
      AuthServices.signupUser(
          emailController.text, passwordController.text, nameController.text, context);
      Navigator.push(context,
          MaterialPageRoute(builder: (ctx) {
            return  LoginScreen();
          }));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields properly")),
      );
    }
  }
}
