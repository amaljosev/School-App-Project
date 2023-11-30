import 'package:cloud_firestore/cloud_firestore.dart';

class TasksDbFunctionsStudent {
  Stream<QuerySnapshot<Object?>> getEventsDatas(
      {required String teacherId, required String collection}) {
    final CollectionReference studentCollection = FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherId)
        .collection(collection);
    final studentsStream = studentCollection.snapshots();

    return studentsStream;
  }
}
