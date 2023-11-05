import 'package:cloud_firestore/cloud_firestore.dart';

class LoginFunctions {
  Future<bool> loginUser(String enteredUsername, String enteredPassword) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: enteredUsername)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // If a document with the entered username exists, check the password.
      final DocumentSnapshot userDoc = querySnapshot.docs.first;
      final String storedPassword = userDoc.get('password');

      if (storedPassword == enteredPassword) {
        // Passwords match; user is authenticated.
        return true;
      }
    }

    // Username doesn't exist or the password doesn't match.
    return false;
  }
}
