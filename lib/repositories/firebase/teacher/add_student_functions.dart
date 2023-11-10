import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolapp/models/student_model.dart';
import 'package:schoolapp/repositories/firebase/database_functions.dart';
import 'package:schoolapp/repositories/firebase/teacher/db_functions_teacher.dart';

class StudentDbFunctions {
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('students');

  Future<void> addStudent(StudentModel studentData) async {
    Map<String, dynamic> studentMap = {
      'first_name': studentData.firstName,
      'second_name': studentData.secondName,
      'class_Teacher': studentData.classTeacher,
      'roll_no': studentData.rollNo,
      'age': studentData.age,
      'register_no': studentData.registerNo,
      'email': studentData.email,
      'contact_no': studentData.contactNo,
      'guardian_name': studentData.guardianName,
      'password': studentData.password,
      'gender': studentData.gender,
      'standard': studentData.standard
    };
    final String? id = await DbFunctionsTeacher().getTeacherIdFromPrefs();
    DbFunctions()
        .addStudentDetails(studentMap, 'teachers', id as String, 'students');
        DbFunctions().addrDetails(studentMap, 'all_students'); 
  }
}
