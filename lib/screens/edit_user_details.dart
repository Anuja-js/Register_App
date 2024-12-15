import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_controller.dart';
import '../models/user.dart';

class UserDetailsEdit extends StatelessWidget {
  final UserDetailsController controller = Get.find<UserDetailsController>();

  UserDetailsEdit(User user, String appBarTitle, {Key? key}) : super(key: key) {
    controller.initialize(user, appBarTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.appBarTitle.value, style: const TextStyle(color: Colors.white))),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(result: false),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background.jpeg",
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
            child: Form(
              key: controller.formKey,
              child: ListView(
                padding: const EdgeInsets.all(15.0),
                children: [
                  GestureDetector(
                    onTap: controller.pickImage,
                    child: Obx(
                          () => CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 50,
                        child: controller.imagePath.value != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            File(controller.imagePath.value!),
                            fit: BoxFit.cover,
                          ),
                        )
                            : const Icon(Icons.camera_alt_outlined, color: Colors.white),
                      ),
                    ),
                  ),
                  buildTextFormField(controller.nameController, 'Name', controller.updateName),
                  buildTextFormField(controller.qualificationController, 'Qualification', controller.updateQualification),
                  buildTextFormField(controller.ageController, 'Age', controller.updateAge, keyboardType: TextInputType.number),
                  buildTextFormField(controller.phoneController, 'Phone', controller.updatePhone, keyboardType: TextInputType.number),
                  buildTextFormField(controller.descriptionController, 'Description', controller.updateDescription),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 19,
            left: 10,
            right: 10,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
              onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
controller.saveUser();
                  }
                },


              child: Obx(() => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    controller.appBarTitle.value == 'Add Student' ? 'Save Student' : 'Update Student',
                    style: const TextStyle(fontSize: 18.0)),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextFormField(
      TextEditingController controller,
      String label,
      Function onChanged, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: (value) => onChanged(),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter $label";
          }
          if (label == 'Phone' && !RegExp(r'^\d{10}$').hasMatch(value)) {
            return "Phone number must be 10 digits";
          }
          if (label == 'Age' && !RegExp(r'^\d{1,3}$').hasMatch(value)) {
            return "Age must be at most 3 digits";
          }
          return null;
        },
      ),
    );
  }
}
