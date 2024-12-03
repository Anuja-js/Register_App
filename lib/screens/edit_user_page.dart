import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../customs/custom_colors.dart';
import '../providers/user_details_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class UserDetailsEdit extends StatelessWidget {
  final String appBarTitle;
  final  documentSnapshot;

  const UserDetailsEdit({
    Key? key,
    required this.appBarTitle,
    this.documentSnapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          UserDetailsProvider()..initialize(appBarTitle, documentSnapshot),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(appBarTitle, style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        body: Consumer<UserDetailsProvider>(
          builder: (context, provider, _) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/background.jpeg",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Form(
                      key: provider.formKey,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        children: <Widget>[
                          InkWell(
                            onTap: () async {
                              // Handle file picking
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                withData: true,
                                allowMultiple: false,
                              );
                              if (result != null) {
                                provider
                                    .updateImageBytes(result.files.first.bytes);
                              }
                            },
                            child: Column(
                              children: [
                                sh10,
                                CircleAvatar(
                                  backgroundColor: black,
                                  radius: 50,
                                  child: provider.imageBytes == null
                                      ? provider.image != "" &&
                                              provider.image != null
                                          ? SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                  provider.image.toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : const Icon(
                                              Icons.camera_alt_outlined,
                                              color: Colors.white)
                                      : provider.imageBytes != null
                                          ? SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.memory(
                                                  provider.imageBytes!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : const Icon(
                                              Icons.camera_alt_outlined,
                                              color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          sh20,
                          buildTextFormField(provider.nameController, 'Name'),
                          buildTextFormField(
                              provider.descriptionController, 'Student ID'),
                          buildTextFormField(provider.qualificationController,
                              'Study Program'),
                          buildTextFormField(provider.ageController, 'Age',
                              keyboardType: TextInputType.number),
                          buildTextFormField(provider.phoneController, 'Phone',
                              keyboardType: TextInputType.number),
                          sh50,
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: black,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            onPressed: () => provider.saveUser(
                                appBarTitle, documentSnapshot, context),
                            child: provider.load
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    appBarTitle == 'Add Student'
                                        ? 'Save Student'
                                        : 'Update Student',
                                    style: TextStyle(color: white),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildTextFormField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: black),
          fillColor: grey,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: grey, width: 2),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: grey, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          if (label == 'Phone' && !RegExp(r'^\d{10}$').hasMatch(value)) {
            return "Phone number must be 10 digits";
          }
          if (label == 'Age' && !RegExp(r'^\d{1,3}$').hasMatch(value)) {
            return "Age must be a valid number";
          }
          return null;
        },
      ),
    );
  }
}
