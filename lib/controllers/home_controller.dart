import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../screens/edit_user_details.dart';
import '../screens/login_screen.dart';
import '../utils/database_helper.dart';

class HomeController extends GetxController {
  // Dependencies
  final DatabaseHelper databaseHelper = DatabaseHelper();

  // Reactive State Management
  RxList<User> userList = <User>[].obs;
  RxBool isGridView = true.obs;
  int count = 0;
  final TextEditingController searchController = TextEditingController();

  // Lifecycle Hook
  @override
  void onInit() {
    super.onInit();
    updateListView();
  }

  // Toggle View State
  void toggleViewMode() {
    isGridView.value = !isGridView.value;
  }

  // Logout Functionality
  Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await prefs.clear();
                Get.offAll(() => LoginScreen());
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  // Update User List from Database
  Future<void> updateListView() async {
    try {
      final users = await databaseHelper.getUserList();
      userList.assignAll(users); // Updates the observable list
      count = users.length;
    } catch (e) {
      print("Error updating user list: $e");
    }
  }

// Search and Filter User List
  void filterUserList(String query) {
    if (query.isNotEmpty) {
      // Fetch the full user list from the database
      databaseHelper.getUserList().then((fullUserList) {
        // Update the observable userList based on the query
        userList.assignAll(
          fullUserList.where((user) =>
              user.name!.toUpperCase().contains(query.toUpperCase())).toList(),
        );
        count = userList.length; // Update the count based on filtered results
      });
    } else {
      updateListView(); // If the query is empty, refresh the entire list
    }
  }


  // Navigate to User Detail Screen
  void navigateToDetail(User user, String title) async{
   var result=await Get.to(() => UserDetailsEdit(user, title));
    if (result) {
      updateListView();
    }
  }

  // Delete User Functionality
  Future<void> deleteUser(int userId) async {
    int result = await databaseHelper.deleteUser(userId);
    if (result != 0) {
      updateListView();
    }
  }
}
