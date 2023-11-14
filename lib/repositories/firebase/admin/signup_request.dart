import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolapp/models/teacher_model.dart';
import 'package:schoolapp/repositories/firebase/database_functions.dart';

class SignUpRequest {
  final CollectionReference teacherDatas =
      FirebaseFirestore.instance.collection('teacher_requests');

  Future<bool> addData(TeacherModel teacherObject) async {
    try {
      Map<String, dynamic> teacherMap = {
        'name': teacherObject.name,
        'class': teacherObject.className,
        'class_id': teacherObject.classId,
        'email': teacherObject.email,
        'contact': teacherObject.contact,
        'password': teacherObject.password,
      };
      final resopnse = await DbFunctions().addDetails(
        map: teacherMap,
        collectionName: 'teacher_requests',
      );
      return resopnse;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot> getTeacherDatas() {
    final teachersStream = teacherDatas.snapshots();
    return teachersStream;
  }

  Future<bool> checkClass(String value) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('teachers')
        .where('class', isEqualTo: value)
        .get();
    final QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
        .collection('teacher_requests') 
        .where('class', isEqualTo: value) 
        .get();

    return querySnapshot.docs.isNotEmpty || querySnapshot2.docs.isNotEmpty;
  }
}
