import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolapp/models/class_model.dart';
import 'package:schoolapp/models/fee_model.dart';
import 'package:schoolapp/models/student_model.dart';
import 'package:schoolapp/repositories/firebase/database_functions.dart';
import 'package:schoolapp/repositories/firebase/teacher/db_functions_teacher.dart';

class StudentDbFunctions {
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('students');

  Future<void> addStudent(StudentModel studentData, FeeModel feeDatas) async {
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
    Map<String, dynamic> studentFeeMap = {
      'total_amount': feeDatas.totalAmount,
      'amount_paid': feeDatas.amountPayed,  
      'amount_pending': feeDatas.amountPending,
    };
    final String? id = await DbFunctionsTeacher().getTeacherIdFromPrefs();
    DbFunctions().addStudentDetails(
        map: studentMap,
        collectionName: 'teachers',
        teacherId: id as String,
        subCollectionName: 'students',
        studentId: studentData.email);
    DbFunctions().addDetails(
        map: studentMap, collectionName: 'all_students', id: studentData.email);
    DbFunctions().addStudentFeeDetails(
        map: studentFeeMap,
        teacherCollectionName: 'teachers',
        teacherId: id,
        studentCollectionName: 'students',
        studentId: studentData.email,
        feeCollectionName: 'student_fee');
  }

  Future<void> updateClassData(ClassModel classData) async {
    try {
      final String? teacherId =
          await DbFunctionsTeacher().getTeacherIdFromPrefs();

      if (teacherId != null) {
        // Reference to the teacher document
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('teachers')
            .doc(teacherId)
            .collection('class')
            .get();
        final classId = querySnapshot.docs.first.id;
        // Reference to the specific document within the subcollection

        // Creating a map of fields you want to update
        Map<String, dynamic> updateData = {
          'class_teacher': classData.classTeacher,
          'standard': classData.standard,
          'total_boys': classData.totalBoys,
          'total_girls': classData.totalGirls,
          'total_students': classData.totalStudents,
        };

        // Update the document in the subcollection
        await DbFunctions().updateDetails(
            map: updateData,
            collectionName: 'teachers',
            teacherId: teacherId,
            subCollectionName: 'class',
            classId: classId);
      }
    } catch (e) {
      // Handle errors, e.g., print or log them
      print('Error updating class data: $e');
    }
  }
}
