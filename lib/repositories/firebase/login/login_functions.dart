import 'package:cloud_firestore/cloud_firestore.dart';

class LoginFunctions {
  Future<bool> teacherLogin(String enteredUsername, String enteredPassword) async { 
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('teachers') 
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
  Future<bool> studentLogin(String enteredUsername, String enteredPassword) async { 
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('students') 
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
