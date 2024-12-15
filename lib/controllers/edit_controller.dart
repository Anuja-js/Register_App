import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registrationapp/controllers/home_controller.dart';
import 'package:registrationapp/screens/home_screen.dart';
import '../models/user.dart';
import '../utils/database_helper.dart';

class UserDetailsController extends GetxController {
  final HomeController controller=Get.find<HomeController>();

  final DatabaseHelper helper = DatabaseHelper();
  final ImagePicker picker = ImagePicker();

  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController qualificationController;
  late TextEditingController ageController;
  late TextEditingController phoneController;
  late TextEditingController descriptionController;

  final RxString appBarTitle = ''.obs;
  final Rx<User> user = User('', '', 0, 0, '').obs;
  final RxnString imagePath = RxnString();

  void initialize(User initialUser, String title) {
    user.value = initialUser;
    appBarTitle.value = title;

    nameController = TextEditingController(text: user.value.name ?? '');
    qualificationController = TextEditingController(text: user.value.qualification ?? '');
    ageController = TextEditingController(text: user.value.age?.toString() ?? '');
    phoneController = TextEditingController(text: user.value.phone?.toString() ?? '');
    descriptionController = TextEditingController(text: user.value.description ?? '');
    imagePath.value = user.value.imagePath;
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  void updateName() {
    user.value.name = nameController.text;
  }

  void updateQualification() {
    user.value.qualification = qualificationController.text;
  }

  void updateAge() {
    user.value.age = int.tryParse(ageController.text);
  }

  void updatePhone() {
    user.value.phone = int.tryParse(phoneController.text);
  }

  void updateDescription() {
    user.value.description = descriptionController.text;
  }

  Future<void> saveUser() async {
    // Assign the image path to the user
    user.value.imagePath = imagePath.value;

    // Validate if the operation is Add or Update based on the appBarTitle value
    if (appBarTitle.value == 'Add Student') {
      // Insert the new user into the database
      await helper.insertUser(user.value);
      Get.snackbar('Success', 'Student added successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      // Update the existing user in the database
      await helper.updateUser(user.value);
      Get.snackbar('Success', 'Student updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    }
   controller.updateListView();
    Get.offAll(HomePage());
  }

}