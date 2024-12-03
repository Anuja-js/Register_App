import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../screens/login_Screen.dart';
class LogOutProvider extends ChangeNotifier{
  void logout(BuildContext ctx) async {
    showDialog(
        context: ctx,
        builder: (ctx1) {
          return AlertDialog(
            title: const Text("Logout"),
            content: const Text("Do you want to logout......?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Close")),
              TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();

                    final shared = await SharedPreferences.getInstance();
                    await shared.setBool('isLoggedIn', false);
                    showSnackbar(ctx, "Logout User succesfully");
                    Get.offAll(() =>  LoginScreen());
                  },
                  child: const Text("Logout")),
            ],
          );
        });
  }
  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
