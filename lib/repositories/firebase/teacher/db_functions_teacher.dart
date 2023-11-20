import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolapp/models/fee_model.dart';
import 'package:schoolapp/repositories/firebase/database_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbFunctionsTeacher {
  String? id = '';
  final CollectionReference teacherCollection =
      FirebaseFirestore.instance.collection('teachers');

  Stream<DocumentSnapshot> getTeacherData(String teacherId) {
    final teacherDocStream = teacherCollection.doc(teacherId).snapshots();
    return teacherDocStream;
  }

  Future<String?> getTeacherIdFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('teacherId');
    
    return prefs.getString('teacherId');
  }
  Future<String?> getStudentIdFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('studentId');
    return prefs.getString('studentId'); 
  }

  Stream<QuerySnapshot<Object?>> getStudentsDatas(teacherId) {
    final CollectionReference studentCollection = FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherId)
        .collection('students');
    final studentsStream = studentCollection.snapshots();
    return studentsStream;
  }

  Stream<QuerySnapshot<Object?>> getClassDetails(teacherId) {
    
    final CollectionReference studentCollection = FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherId)
        .collection('class');
    final studentsStream = studentCollection.snapshots();
    
    return studentsStream;
  }
  Stream<QuerySnapshot<Object?>> getCurrentAttendanceData(teacherId) {
    
    final CollectionReference studentCollection = FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherId)
        .collection('attendance'); 
    final studentsStream = studentCollection.snapshots();
    
    return studentsStream;
  }

  Future<void> updateStudentFeeDatas(
      FeeModel feeDatas, String studentId) async {
    try {
      final String? teacherId =
          await DbFunctionsTeacher().getTeacherIdFromPrefs();

      if (teacherId != null) {
        // Reference to the teacher document
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('teachers')
            .doc(teacherId)
            .collection('students')
            .doc(studentId)
            .collection('student_fee')
            .get();
        final feeId = querySnapshot.docs.first.id;
        // Reference to the specific document within the subcollection

        // Creating a map of fields you want to update
        Map<String, dynamic> studentFeeMap = {
          'total_amount': feeDatas.totalAmount,
          'amount_paid': feeDatas.amountPayed,
          'amount_pending': feeDatas.amountPending,
        };

        // Update the document in the subcollection
        await DbFunctions().updateStudentFeeDetails(
            map: studentFeeMap,
            teacherCollectionName: 'teachers',
            teacherId: teacherId,
            studentCollectionName: 'students',
            studentId: studentId,
            feeId: feeId);
      }
    } catch (e) {
      // Handle errors, e.g., print or log them
      print('Error updating class data: $e');
    }
  }
}
