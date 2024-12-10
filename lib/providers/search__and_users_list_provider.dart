import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
class SearchProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  String searchText = '';
  List<DocumentSnapshot> userList = []; // Full user list
  List<DocumentSnapshot> filteredList = []; // Filtered search results

  // Fetch students from Firestore
  void fetchStudents() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection("Students").get();
    userList = querySnapshot.docs;
    filteredList = userList; // Initialize filteredList
    notifyListeners();
  }

  // Filter the search results
  void filterSearch(String query) {
    if (query.isNotEmpty) {
      filteredList = userList
          .where((student) => student["studentName"]
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase()))
          .toList();
    } else {
      filteredList = userList;
    }
    notifyListeners(); // Notify listeners of the change
  }
  void delete(BuildContext context, {required String name}) async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("Students").doc(name);

    try {
      await documentReference.delete();
      filteredList.removeWhere((element) => element.id == documentReference.id);
      showSnackbar(context, 'User Deleted Successfully');
      notifyListeners();
    } catch (e) {
      showSnackbar(context, 'Error deleting user: $e');
    }
Get.back();
  }
  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void showDeleteDialog(
      BuildContext context, DocumentSnapshot documentSnapshot) {
    notifyListeners();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete...?"),
          content: const Text("Are you sure? This will be deleted."),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Dismiss dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                delete(context, name: documentSnapshot["studentName"]);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
