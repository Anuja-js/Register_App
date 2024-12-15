// ignore_for_file: use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registrationapp/customs/text_custom.dart';
import '../controllers/login_controller.dart';
import '../customs/constants.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();
    return Scaffold(
      backgroundColor:white,
      body: Stack(
        children:[
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset("assets/images/background.jpeg",fit: BoxFit.fill,)),
          Positioned(
            top: 100,
            left: 10,
            right: 10,
            bottom: 10,
            child: Form(
            key: controller.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/splash.png",
                      width: 50.w,height: 50.h,
                    ),
                    sw10,
                     TextCustom(text: "Log In")
                  ],
                ),
               sh20,
                TextFormField(
                  style:  TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Courier',
                  ),
                  controller: controller.nameController,
                  keyboardType: TextInputType.name,
                  decoration:  InputDecoration(
                    labelText: 'Enter Your Name',
                    labelStyle: const TextStyle(
                      color:black,
                    ),
                    fillColor: grey,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color:grey, width: 2.w)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:red, width: 2.w)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color:grey, width: 2.w),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Name";
                    } else {
                      return null;
                    }
                  },
                ),
               sh20,
                Obx(
                      () => TextFormField(
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier',
                    ),
                    controller: controller.passwordController,
                    obscureText: controller.obscure.value,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: controller.isObscure,
                        icon: Icon(
                          controller.obscure.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: black,
                        ),
                      ),
                      labelText: "Enter Your Password",
                      labelStyle: const TextStyle(color: black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: grey, width: 2.w),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: red, width: 2.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: grey, width: 2.w),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Password";
                      }
                      return null;
                    },
                  ),
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.formkey.currentState!.validate()) {
                        controller.checkLogIn(context);
                      } else {
                         if (kDebugMode) {
                           print("Data Empty");
                         }
                      }
                      // checkLogIn(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(black),
                      foregroundColor:MaterialStateProperty.all(white),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                            vertical: 15.h,
                            horizontal: MediaQuery.of(context).size.width / 2.5.w),
                      ),
                    ),
                    child:  TextCustom(text: "LogIn",color:white,),
                  ),
                ),
               sh50,
              ],
            ),
        ),
          ),
          ]
      ),
    );
  }
}
