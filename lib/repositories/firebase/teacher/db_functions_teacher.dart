import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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
}
