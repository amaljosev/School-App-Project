import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolapp/models/teacher_model.dart';

class SignUpRequest {
  final CollectionReference teacherDatas =
      FirebaseFirestore.instance.collection('teacher_requests');

  addData(TeacherModel teacherObject) async {
    Map<String, dynamic> teacherMap = {
      'name': teacherObject.name,
      'class': teacherObject.className,
      'email': teacherObject.email,
      'contact': teacherObject.contact, 
      'password': teacherObject.password,
    };
    await addteacherDetails(teacherMap);
    
  }

  Future<void> addteacherDetails(Map<String, dynamic> teacherMap) async {
    return await FirebaseFirestore.instance
        .collection("teacher_requests")
        .doc()
        .set(teacherMap);
  }
  

  Stream<QuerySnapshot> getTeacherDatas() {
    final teachersStream = teacherDatas.snapshots();
    return teachersStream;
  }
}
