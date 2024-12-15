// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:registrationapp/controllers/home_controller.dart';
import 'package:registrationapp/customs/text_custom.dart';
import '../customs/constants.dart';
import '../models/user.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetails extends StatelessWidget {
  final User user;
  const UserDetails(this.user, {super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
          text: user.name!,
          color: white,
          textSize: 15.sp,
        ),
        backgroundColor: black,
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                "assets/images/background.jpeg",
                fit: BoxFit.fill,
              )),
          Positioned(
            left: MediaQuery.of(context).size.width / 2.55,
            top: 20,
            child: CircleAvatar(
              backgroundColor: black,
              radius: 50.r,
              child: user.imagePath != null
                  ? SizedBox(
                      width: 100.w,
                      height: 100.h,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.file(
                            File(
                              user.imagePath!,
                            ),
                            fit: BoxFit.cover,
                          )),
                    )
                  : const Icon(Icons.person, color: white),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 5.h,
            left: 20.w,
            right: 20.w,
            bottom: 20.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextCustom(
                  text: 'Name',
                  textSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
                TextCustom(
                  text: user.name.toString(),
                  textSize: 15.sp,
                  color: black,
                ),
                sh10,
                TextCustom(
                  text: 'Qualification',
                  textSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
                TextCustom(
                  text: user.qualification.toString(),
                  textSize: 15.sp,
                  color: black,
                ),
                sh10,
                TextCustom(
                  text: 'Age',
                  textSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
                TextCustom(
                  text: user.age.toString(),
                  textSize: 15.sp,
                  color: black,
                ),
                sh10,
                TextCustom(
                  text: 'Phone',
                  textSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
                TextCustom(
                  text: user.phone.toString(),
                  textSize: 15.sp,
                  color: black,
                ),
                sh10,
                TextCustom(
                  text: 'Description',
                  textSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
                TextCustom(
                  text: user.description.toString(),
                  textSize: 15.sp,
                  color: black,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 4.5,
            left: 25,
            right: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    controller.navigateToDetail(user, user.name.toString());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: black, foregroundColor: white),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                    child: TextCustom(
                      text: 'Edit',
                      color: white,
                    ),
                  ),
                ),
                sw10,
                ElevatedButton(
                  onPressed: () {
                    controller.showDeleteConfirmationDialog(user);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: black, foregroundColor: white),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Text('Delete'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
