import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginFunctions {
  Future<bool> teacherLogin(
      String enteredUsername, String enteredPassword) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('teachers')
        .where('email', isEqualTo: enteredUsername)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // If a document with the entered username exists, check the password.
      final DocumentSnapshot teacherDoc = querySnapshot.docs.first;
      final String storedPassword = teacherDoc.get('password');

      if (storedPassword == enteredPassword) {
        // Passwords match; user is authenticated.
        final String teacherId = teacherDoc.id;
        SharedPreferences prefsTeacherId = await SharedPreferences.getInstance();
        prefsTeacherId.setString('teacherId', teacherId); 
          
        return true;
      
      }
    }
    // Username doesn't exist or the password doesn't match.
    return false;
  }

  Future<bool> studentLogin(
      String enteredUsername, String enteredPassword) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('all_students') 
        .where('email', isEqualTo: enteredUsername)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // If a document with the entered username exists, check the password.
      final DocumentSnapshot studentDoc = querySnapshot.docs.first;
      final String storedPassword = studentDoc.get('password');

      if (storedPassword == enteredPassword) {
        // Passwords match; user is authenticated.
        return true;
      }
    }
    // Username doesn't exist or the password doesn't match.
    return false;
  }

  
}
