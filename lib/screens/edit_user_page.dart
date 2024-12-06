import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/user_details_provider.dart';
import '../customs/custom_colors.dart';

class UserDetailsEdit extends StatefulWidget {
  final String appBarTitle;
  final dynamic documentSnapshot;

  const UserDetailsEdit({
    Key? key,
    required this.appBarTitle,
    this.documentSnapshot,
  }) : super(key: key);

  @override
  State<UserDetailsEdit> createState() => _UserDetailsEditState();
}

class _UserDetailsEditState extends State<UserDetailsEdit> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserDetailsProvider()
        ..initialize(widget.appBarTitle, widget.documentSnapshot),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.appBarTitle, style: const TextStyle(color: Colors.white)),
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
                              FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                                type: FileType.image,
                                withData: true,
                                allowMultiple: false,
                              );
                              if (result != null) {
                                provider.updateImageBytes(result.files.first.bytes);
                              }
                            },
                            child: CircleAvatar(
                              backgroundColor: black,
                              radius: 50,
                              child: provider.imageBytes == null
                                  ?provider.image!=null&&  provider.image!.isNotEmpty
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  provider.image.toString(),
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                                  : const Icon(Icons.camera_alt_outlined, color: Colors.white)
                                  : ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.memory(
                                  provider.imageBytes!,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                          ),
                          sh20,
                          buildTextFormField(provider.nameController, 'Name'),
                          buildTextFormField(provider.descriptionController, 'Student ID'),
                          buildTextFormField(provider.qualificationController, 'Study Program'),
                          buildTextFormField(provider.ageController, 'Age', keyboardType: TextInputType.number),
                          buildTextFormField(provider.phoneController, 'Phone', keyboardType: TextInputType.number),
                          sh50,
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: black,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            onPressed: () => provider.saveUser(
                              widget.appBarTitle,
                              widget.documentSnapshot,
                              context,
                            ),
                            child: provider.load
                                ? const CircularProgressIndicator()
                                : Text(
                              widget.appBarTitle == 'Add Student'
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
