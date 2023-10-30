import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolapp/models/teacher_model.dart';
import 'package:schoolapp/repositories/firebase/database_functions.dart';

class SignUpRequest {
  final CollectionReference teacherDatas =
      FirebaseFirestore.instance.collection('teacher_requests');
  final CollectionReference classCollection =
      FirebaseFirestore.instance.collection('classes');

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
    deleteClass(teacherObject.classId);
  }

  Future<void> deleteClass(String id) async {
    await classCollection.doc(id).delete();
  }

  Stream<QuerySnapshot> getTeacherDatas() {
    final teachersStream = teacherDatas.snapshots();
    return teachersStream;
  }
}
