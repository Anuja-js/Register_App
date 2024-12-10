import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registrationapp/providers/logout_provider.dart';
import 'package:registrationapp/providers/search__and_users_list_provider.dart';
import 'package:registrationapp/providers/user_details_provider.dart';
import 'package:registrationapp/screens/home_screen.dart';
import 'package:registrationapp/screens/login_screen.dart';
import 'package:registrationapp/screens/sign_up.dart';
import 'package:registrationapp/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'providers/form_provider.dart';
import 'providers/sign_up_provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => LogOutProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_ , child) {
          return GetMaterialApp(
      title: "Student App",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>  SplashScreen(),
        '/login': (context) =>  LoginScreen(),
        '/signup':(context)=> SignUpScreen(),
        '/home':(context)=> HomeScreen(),
      },
    );});
  }
}
