import 'package:cloud_firestore/cloud_firestore.dart';
class FirestoreServices {
  // Static method to save user data to Firestore
  static Future<void> saveUser(String name, String email, String uid) async {
    // Reference to the Firestore instance, accessing the 'users' collection
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({
      'email': email,
      'name': name,
    });
  }
}
