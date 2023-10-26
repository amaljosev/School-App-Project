import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolapp/models/student_model.dart';
import 'package:schoolapp/repositories/firebase/database_functions.dart';

class StudentDbFunctions {
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('students');

  Future<void> addStudent(StudentModel studentData) async {
    Map<String, dynamic> studentMap = {
      'roll_no':studentData.rollNo,
      'name': studentData.name,
      'age': studentData.age,
      'class': studentData.className,
      'register_no': studentData.registerNo,
      'email': studentData.email,
      'contact': studentData.contactNo,
      'guardian': studentData.guardianName,
      'password': studentData.password,
    };
    DbFunctions().addrDetails(studentMap, 'students');
  }
}
