
import 'package:cloud_firestore/cloud_firestore.dart';

class DbFunctionsTeacherHomeWork {
  Stream<QuerySnapshot<Object?>> getHomeWorksDatas(teacherId) {
    final CollectionReference homeWorkCollection = FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherId)
        .collection('home_works');
    final studentsStream = homeWorkCollection.snapshots();
    return studentsStream;
  }

  Stream<QuerySnapshot<Object?>> getAssignmentDatas(teacherId) {
    final CollectionReference assignmentCollection = FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherId)
        .collection('assignments');

    final studentsStream = assignmentCollection.snapshots();

    return studentsStream;
  }
}
