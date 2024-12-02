// ignore_for_file: use_build_context_synchronously
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart'; // Add this import to use kDebugMode
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:registrationapp/screens/home_screen.dart';

class FormProvider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Reactive variables
  bool obscurePassword = true;
  bool _login = false;

  bool get login => _login;
  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
  Future<void> isLogedUser(BuildContext context, String emailController, String passwordController) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (kDebugMode) {
        print("Email: $emailController, Password: $passwordController");
      }

      try {
        // Attempt to sign in with the provided email and password
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController,
          password: passwordController,
        );

        _login = true; // Update private variable
        saveSharedPreference(context, _login);

        if (!context.mounted) return;

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('User logged in successfully'),
        ));

        // Navigate to HomeScreen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) {
          return const HomeScreen();
        }));
      } catch (e) {
        if (!context.mounted) return;

        if (e is FirebaseAuthException) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 1),
            content: Text(e.message ?? 'An error occurred!'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 1),
            content: Text('User not found!'),
          ));
        }
        if (kDebugMode) {
          print("Login failed: $e");
        }
      }
    } else {
      _login = false;
      if (kDebugMode) {
        print("Form validation failed");
      }
    }
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
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  // Placeholder for shared preference saving logic
  Future<void> saveSharedPreference(BuildContext context, bool loginStatus) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setBool('isLoggedIn', loginStatus);
  }}

