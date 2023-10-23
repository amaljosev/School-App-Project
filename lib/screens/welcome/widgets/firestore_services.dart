
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:schoolapp/screens/models/teacher_model.dart';

class FireStoreServices { 
  // final CollectionReference teacherDatas =
  //     FirebaseFirestore.instance.collection('teacher');

  // Future<void> addData(TeacherModel teacherObject) {
  //   return teacherDatas.add({
  //     'name': teacherObject.name,
  //     'class': teacherObject.className,
  //     'email': teacherObject.email,
  //     'contact': teacherObject.contact,
  //     'password': teacherObject.password,
  //     'timestamp': teacherObject.time,
  //   });
  // }

  // Stream<QuerySnapshot> getTeacherDatas() {
  //   final teachersStream =
  //       teacherDatas.orderBy('timestamp', descending: true).snapshots();
  //       return teachersStream;
  // }

  addData(TeacherModel teacherObject) async {
    Map<String, dynamic> teacherMap = {
      'name': teacherObject.name, 
      'class': teacherObject.className,
      'email': teacherObject.email,
      'contact': teacherObject.contact,
      'password': teacherObject.password,
    };
    await addteacherDetails(teacherMap);
    Fluttertoast.showToast(
        msg: "Data Uploaded Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future addteacherDetails(Map<String, dynamic> teacherMap) async {
    return await FirebaseFirestore.instance
        .collection("teachers")
        .doc()
        .set(teacherMap);
  }
}
