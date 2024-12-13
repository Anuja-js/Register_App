
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registrationapp/controllers/home_controller.dart';
import 'package:registrationapp/controllers/login_controller.dart';
import 'package:registrationapp/controllers/user_details_controller.dart';
import 'package:registrationapp/screens/splash_screen.dart';
import 'controllers/splash_controller.dart';
const saveKey = "userLoggedIn";
class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(SplashController());
    Get.put(LoginController());
    Get.put(DetailsController());
  }
}

void main(){
  runApp( const MyApp()
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_ , child) { return GetMaterialApp(
      initialBinding: InitialBindings(),
      title: "Users",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurple
      ),
      home:  SplashScreen(),
    );
        });
  }
}
