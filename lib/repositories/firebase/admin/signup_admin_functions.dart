import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminActions {
  final CollectionReference teacherDatas =
      FirebaseFirestore.instance.collection('teacher_requests');

  final CollectionReference teacherCollection =
      FirebaseFirestore.instance.collection('teachers'); 

   

  Future<void> addteacherDetails(Map<String, dynamic> teacherMap) async { 
    return await FirebaseFirestore.instance
        .collection("teachers")
        .doc()
        .set(teacherMap);
  }
 Stream<QuerySnapshot> getTeacherDatas() {
    final teachersStream = teacherCollection.snapshots(); 
    return teachersStream;
  }


  Future<void> acceptRequest(String id) async {
  // Get the document snapshot from the "teacher_requests" collection
  final DocumentSnapshot teacherRequestSnapshot = await teacherDatas.doc(id).get();

  if (teacherRequestSnapshot.exists) {
    // Extract the data from the teacher request document
    Map<String, dynamic> teacherData = teacherRequestSnapshot.data() as Map<String, dynamic>;

    // Add the data to the "teachers" collection
    await addteacherDetails(teacherData);

    // Delete the document from the "teacher_requests" collection 
    await teacherDatas.doc(id).delete();
  } else {
    // Handle the case where the document does not exist
    log("Teacher request document with ID $id does not exist.");
  }
}
  Future<void> rejectRequest(String id) async {
    await teacherDatas.doc(id).delete();
  }


}
