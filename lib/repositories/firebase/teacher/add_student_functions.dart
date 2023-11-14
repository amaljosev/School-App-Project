import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolapp/models/class_model.dart';
import 'package:schoolapp/models/fee_model.dart';
import 'package:schoolapp/models/student_model.dart';
import 'package:schoolapp/repositories/firebase/database_functions.dart';
import 'package:schoolapp/repositories/firebase/teacher/db_functions_teacher.dart';

class StudentDbFunctions {
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('students');

  Future<bool> addStudent({
    required StudentModel studentData,
    required FeeModel feeDatas,
  }) async {
    try {
      final String? id = await DbFunctionsTeacher().getTeacherIdFromPrefs();
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
      final bool response = await DbFunctions().addStudentDetails(
        map: studentMap,
        collectionName: 'teachers',
        teacherId: id as String,
        subCollectionName: 'students',
      );
      final bool response2 = await DbFunctions()
          .addDetails(map: studentMap, collectionName: 'all_users');
      addClassAndFeeData(feeDatas, studentData.registerNo);
      return response && response2;
    } catch (e) {
      return false;
    }
  }

  Future<void> addClassAndFeeData(FeeModel feeDatas, String regNo) async {
    try {
      final String? teacherId =
          await DbFunctionsTeacher().getTeacherIdFromPrefs();

      if (teacherId != null) {
        // Reference to the teacher document
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('teachers')
            .doc(teacherId)
            .collection('students')
            .where('register_no', isEqualTo: regNo)
            .get();
        final studentId = querySnapshot.docs.first.id;

        Map<String, dynamic> studentFeeMap = {
          'total_amount': feeDatas.totalAmount,
          'amount_paid': feeDatas.amountPayed,
          'amount_pending': feeDatas.amountPending,
        };
        DbFunctions().addStudentFeeDetails(
            map: studentFeeMap,
            teacherCollectionName: 'teachers',
            teacherId: teacherId,
            studentCollectionName: 'students',
            studentId: studentId,
            feeCollectionName: 'student_fee');
      }
    } catch (e) {
      // Handle errors, e.g., print or log them
      print('Error updating class data: $e');
    }
  }

  Future<bool> updateClassData(ClassModel classData) async {
    bool response = false;
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
        response = await DbFunctions().updateDetails(
            map: updateData,
            collectionName: 'teachers',
            teacherId: teacherId,
            subCollectionName: 'class',
            classId: classId);
      }
      return response;
    } catch (e) {
      // Handle errors, e.g., print or log them
      log('Error updating class data: $e');
      return false;
    }
  }

  Future<void> updateStudentData(
      StudentModel studentData, String studentId) async {
    try {
      final String? teacherId =
          await DbFunctionsTeacher().getTeacherIdFromPrefs();

      if (teacherId != null) {
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
        await DbFunctions().updateDetails(
            map: studentMap,
            collectionName: 'teachers',
            teacherId: teacherId,
            subCollectionName: 'students',
            classId: studentId);
      }
    } catch (e) {
      print('Error updating class data: $e');
    }
  }
}
