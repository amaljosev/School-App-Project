import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolapp/repositories/firebase/database_functions.dart';

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

  Future<bool> addLeaveApplicationWork(
      String teacherId, String date, String reason, String name) async {
    try {
      Map<String, dynamic> homeWorkMap = {
        'absent_date': date, 
        'reason': reason,
        'name': name,
        'date': DateTime.now()
      };

      final bool resopnse = await DbFunctions().addSubCollection(
          map: homeWorkMap,
          collectionName: 'teachers',
          teacherId: teacherId,
          subCollectionName: 'leave_applications');
      return resopnse;
    } catch (e) {
      return false;
    }
  }
}
