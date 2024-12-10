// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../controllers/login_controller.dart';
import '../customs/custom_colors.dart';
import '../customs/logo_image.dart';
import '../customs/text_custom.dart';
import '../providers/form_provider.dart';
import 'sign_up.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());// Di

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background.jpeg",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 100,
            left: 10,
            right: 10,
            bottom: 10,
            child: Form(
              key: formProvider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LogoImage(text: 'Login'),
               sh20,
                  ConstrainedBox(
                    constraints:  BoxConstraints(maxWidth: 350.w),
                    child: TextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: formProvider.validateEmail,
                      decoration:  InputDecoration(
                        labelText: "Enter Your Email",
                        labelStyle: const TextStyle(color:black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: grey, width: 2.w),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: red, width: 2.w),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:grey, width: 2.w),
                        ),
                      ),
                    ),
                  ),
                  sh20,
                  ConstrainedBox(
                    constraints:  BoxConstraints(maxWidth: 350.w),
                    child: Obx(
                          () => TextFormField(
                        controller: controller.passwordController,
                        obscureText: !controller.obscurePass.value,
                        keyboardType: TextInputType.visiblePassword,
                        validator: formProvider.validatePassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.toggleObscurePass();
                              },
                            icon: Icon(
                              controller.obscurePass.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: controller.obscurePass.value
                                  ?black:grey,
                            ),
                          ),
                          labelText: "Enter Your Password",
                          labelStyle: const TextStyle(color:black),
                          border:  OutlineInputBorder(
                            borderSide: BorderSide(color:grey, width: 2.w),
                          ),
                          errorBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color:red, width: 2.w),
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color:grey, width: 2.w),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(
                        () => ConstrainedBox(
                      constraints:  BoxConstraints(
                        maxWidth: 350.w,
                        minHeight: 40.h,
                        minWidth: 350.w,
                      ),
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                          if (formProvider.formKey.currentState?.validate() ?? false) {
                           formProvider.isLogedUser(context,controller.emailController.text,controller.passwordController.text);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(black),
                          foregroundColor: MaterialStateProperty.all(white),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(color: white)
                            : TextCustom(text: "Log In", color:white),
                      ),
                    ),
                  ),
                 sh10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextCustom(text: "Don't have an account?", color:black),
                      TextButton(
                        onPressed: () => Get.off(() => SignUpScreen()),
                        child: TextCustom(text: "Sign Up", color:blue),
                      ),
                    ],
                  ),
                sh20,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
