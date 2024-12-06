import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:registrationapp/screens/home_screen.dart';
import 'dart:typed_data';
import 'package:get/get.dart';

import '../customs/custom_colors.dart';
import '../customs/text_custom.dart';

class UserDetailsProvider extends ChangeNotifier {

  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Uint8List? imageBytes;
  File? imagefile;
  bool isPress = false;
  bool load = false;
  String? image;
  final formKey = GlobalKey<FormState>();
  void initialize(String appBarTitle, DocumentSnapshot? documentSnapshot) {
    print("...................................................${documentSnapshot?.id.toString()}");
    if ( documentSnapshot != null) {
      nameController.text = documentSnapshot['studentName'] ?? '';
      descriptionController.text = documentSnapshot['studentId'] ?? '';
      qualificationController.text = documentSnapshot['studyProgram'] ?? '';
      ageController.text = documentSnapshot['age']?.toString() ?? '';
      phoneController.text = documentSnapshot['phone'] ?? '';
      image = documentSnapshot['image'] ?? '';
      notifyListeners();
    }

  }

  Future<String> uploadImage(Uint8List imageBytes) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference imageRef = storageRef.child('images/$fileName');
      final metadata = SettableMetadata(contentType: 'image/jpeg');
      await imageRef.putData(imageBytes, metadata);
      // Get the download URL
      String downloadUrl = await imageRef.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveUser(String appBarTitle, DocumentSnapshot? documentSnapshot,BuildContext context) async {
    if (formKey.currentState!.validate()) {

        load = true;
    notifyListeners();

      try {
        // Create a reference to the Firestore document for the student
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection("Students")
            .doc(nameController.text);

        String imageUrl = "";

        // Handle image uploading logic
        if (imageBytes != null) {
          imageUrl = await uploadImage(imageBytes!);
        } else {
          if (appBarTitle == "Edit User") {
            imageUrl = image!.toString();
          }
        }

        // Data to be added/updated in Firestore
        Map<String, dynamic> student = {
          "studentName": nameController.text,
          "studentId": descriptionController.text,
          "studyProgram": qualificationController.text,
          "age": ageController.text,
          "phone": phoneController.text,
          "image": imageUrl
        };

        // If editing an existing user
        if (appBarTitle != "Add Student") {
          // First delete the old document with the previous student name
          await FirebaseFirestore.instance
              .collection("Students")
              .doc(documentSnapshot?["studentName"])
              .delete();

          // Set the updated data
          await documentReference.set(student).whenComplete(() {});
        } else {
          // Add new student
          await documentReference.set(student).whenComplete(() {});
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 1),
          content: appBarTitle == 'Add Student'
              ? TextCustom(
            text: 'Student Added Successfully',
            color: white,
          )
              : TextCustom(
            color: white,
            text: 'Student Updated Successfully',
          ),
        ));

          load = false;
      notifyListeners();
Get.offAll(HomeScreen());

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e'),
        ));
      } finally {

          load = false;
      notifyListeners();
      }
    }
  }

  void updateImageBytes(Uint8List? bytes) {
    imageBytes = bytes;
    notifyListeners();
  }

}
