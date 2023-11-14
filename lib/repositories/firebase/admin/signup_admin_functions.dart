import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolapp/repositories/firebase/database_functions.dart';

class AdminActions {
  final CollectionReference teacherDatas =
      FirebaseFirestore.instance.collection('teacher_requests');

  final CollectionReference teacherCollection =
      FirebaseFirestore.instance.collection('teachers');

  Stream<QuerySnapshot> getTeacherDatas() {
    final teachersStream = teacherCollection.snapshots();
    return teachersStream;
  }

  Future<void> acceptRequest(String id) async {
    final DocumentSnapshot teacherRequestSnapshot =
        await teacherDatas.doc(id).get();

    if (teacherRequestSnapshot.exists) {
      // Extract the data from the teacher request document
      Map<String, dynamic> teacherData =
          teacherRequestSnapshot.data() as Map<String, dynamic>;

      String classTeacherName = teacherData['name'] ?? '';
      String standard = teacherData['class'] ?? '';

      Map<String, dynamic> classData = {
        'total_students': 0,
        'total_boys': 0,
        'total_girls': 0,
        'class_teacher': classTeacherName,
        'standard': standard,
      };

      // Add the data to the "teachers" collection
      await DbFunctions()
          .addDetails(map: teacherData, collectionName: 'teachers');

      // Delete the document from the "teacher_requests" collection

      await teacherDatas.doc(id).delete();
      addClassData(classData,standard); 
    } else {
      // Handle the case where the document does not exist
      log("Teacher request document with ID $id does not exist.");
    }
  }

  Future<void> rejectRequest(String id) async {
    await teacherDatas.doc(id).delete();
  }

  Future<void> addClassData(Map<String, dynamic> classData,String enteredname) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance 
        .collection('teachers')
        .where('class', isEqualTo: enteredname)
        .get();
      final teacherId = querySnapshot.docs.first.id; 
      await DbFunctions().addClassDetails(
          map: classData, 
          collectionName: 'teachers',
          teacherId: teacherId, 
          subCollectionName: 'class');
    } catch (e) {
      print('Error updating class data: $e');
    }
  }
}
