import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbFunctionsTeacher {
  final CollectionReference teacherCollection =
      FirebaseFirestore.instance.collection('teachers');

  Stream<DocumentSnapshot> getTeacherData(String teacherId) {
    final teacherDocStream = teacherCollection.doc(teacherId).snapshots();
    return teacherDocStream;
  }

  Future<String?> getTeacherIdFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('teacherId');
  }



}
