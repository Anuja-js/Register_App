import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/signup_controller.dart';
import '../customs/custom_colors.dart';
import '../customs/logo_image.dart';
import '../customs/text_custom.dart';
import '../providers/sign_up_provider.dart';
import '../screens/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
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
      child:
          Form(
            key: formProvider.formKey,
            child: Column(
              children: [
                LogoImage(text: 'SignUp'),
                sh20,
                ConstrainedBox(
                  constraints:  BoxConstraints(maxWidth: 350.w),
                  child: TextFormField(
                    controller: formProvider.nameController,
                    decoration:  InputDecoration(
                      labelText: "Enter Your Name",
                      labelStyle: TextStyle(color:black),
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
                    validator: formProvider.validateName,
                  ),
                ),
                sh20,
                TextFormField(
                  controller: formProvider.emailController,
                  decoration:  InputDecoration(
                    labelText: "Enter Your Email",
                    labelStyle: TextStyle(color:black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: grey, width: 2.w),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: red, width: 2.w),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:grey, width: 2.w),
                    ),
                  ), validator: formProvider.validateEmail,
                ),
                sh20,
                Obx(() => TextFormField(
                  controller: formProvider.passwordController,
                  obscureText: !controller.obscurePass.value,
                  keyboardType: TextInputType.visiblePassword,
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

                  validator: formProvider.validatePassword,
                )),
                Spacer(),
            ConstrainedBox(
                constraints:  BoxConstraints(
                  maxWidth: 350.w,
                  minHeight: 40.h,
                  minWidth: 350.w,
                ),
                child:  ElevatedButton(
                    onPressed: () => formProvider.saveForm(context),
                    child: const Text("Sign Up"),
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(black),
                  foregroundColor: MaterialStateProperty.all(white),
                ),
                  ),),

                sh10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextCustom(text: "Do you have an account?", color:black),
                    TextButton(
                      onPressed: () => Get.off(() => LoginScreen()),
                      child: TextCustom(text: "Log In", color:blue),
                    ),
                  ],
                ),
                sh20,
              ],
            ),
          ),),
        ],
      ),
    );
  }
}
