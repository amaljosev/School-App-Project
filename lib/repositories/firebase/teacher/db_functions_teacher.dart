import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbFunctionsTeacher {
  final CollectionReference teacherCollection =
      FirebaseFirestore.instance.collection('teachers');

  Stream<DocumentSnapshot> getTeacherData(String teacherId) { 
    final teacherDocStream = teacherCollection.doc(teacherId).snapshots();
    return teacherDocStream;
  }
}
