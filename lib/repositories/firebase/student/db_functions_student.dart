import 'package:cloud_firestore/cloud_firestore.dart';

class DbFunctionsStudent {
  Stream<DocumentSnapshot<Object?>> getStudentsDatas(
      String teacherId, String studentId) {
    try {
      final DocumentReference studentDocument = FirebaseFirestore.instance
          .collection('teachers')
          .doc(teacherId)
          .collection('students')
          .doc(studentId);

      final studentsStream = studentDocument.snapshots();
      return studentsStream;
    } catch (error) {
      rethrow;
    }
  }
}
