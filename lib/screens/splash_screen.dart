import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registrationapp/customs/constants.dart';
import 'package:registrationapp/customs/text_custom.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset("assets/images/background.jpeg", fit: BoxFit.fill),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/splash.png",
                  width: 150.w,
                  height: 160.h,
                ),
              sh20,
                 TextCustom(
                 text:  "Students Register",
                 textSize: 20.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
