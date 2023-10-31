import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolapp/models/teacher_model.dart';
import 'package:schoolapp/repositories/firebase/database_functions.dart';

class SignUpRequest {
  final CollectionReference teacherDatas =
      FirebaseFirestore.instance.collection('teacher_requests');

  addData(TeacherModel teacherObject) async {
    Map<String, dynamic> teacherMap = {
      'name': teacherObject.name,
      'class': teacherObject.className,
      'class_id': teacherObject.classId,
      'email': teacherObject.email,
      'contact': teacherObject.contact,
      'password': teacherObject.password,
      'students': '0',
    };
    await DbFunctions().addrDetails(teacherMap, 'teacher_requests');
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

    return querySnapshot.docs.isNotEmpty;
  }
}
