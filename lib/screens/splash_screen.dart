// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registrationapp/customs/custom_colors.dart';
import 'package:registrationapp/customs/text_custom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
   const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());

@override
  void initState() {
    splashController.checkUserLoggedIn();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Image.asset(
            "assets/images/background.jpeg",
            fit: BoxFit.fill,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/splash.png",
                width: 140.w,
                height: 140.h,
              ),
          sh20,
              TextCustom(
                text: "My Students",
                textSize: 20.sp,
                color: black,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

