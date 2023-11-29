import 'package:cloud_firestore/cloud_firestore.dart';

class DbFunctionsTeacherHomeWork {
  Stream<QuerySnapshot<Object?>> getHomeWorksDatas(teacherId) {
    final CollectionReference studentCollection = FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherId)
        .collection('home_works');
    final studentsStream = studentCollection.snapshots();
    return studentsStream;
  }
}
