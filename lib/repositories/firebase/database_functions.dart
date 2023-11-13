import 'package:cloud_firestore/cloud_firestore.dart';

class DbFunctions {
  Future<void> addDetails(
      {required Map<String, dynamic> map,
      required String collectionName,
      required String id}) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .set(map);
  }

  Future<void> addClassDetails(
      {required Map<String, dynamic> map,
      required String collectionName,
      required String teacherId,
      required String subCollectionName}) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(teacherId)
        .collection(subCollectionName)
        .doc()
        .set(map);
  }

  Future<void> addStudentDetails({
    required Map<String, dynamic> map,
    required String collectionName,
    required String teacherId,
    required String subCollectionName,
  }) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(teacherId)
        .collection(subCollectionName)
        .doc()
        .set(map);
  }

  Future<void> updateDetails(
      {required Map<String, dynamic> map,
      required String collectionName,
      required String teacherId,
      required String subCollectionName,
      required String classId}) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(teacherId)
        .collection(subCollectionName)
        .doc(classId)
        .update(map);
  }

  Future<void> addStudentFeeDetails(
      {required Map<String, dynamic> map,
      required String teacherCollectionName,
      required String teacherId,
      required String studentCollectionName,
      required String studentId,
      required String feeCollectionName}) async {
    return await FirebaseFirestore.instance
        .collection(teacherCollectionName)
        .doc(teacherId)
        .collection(studentCollectionName)
        .doc(studentId)
        .collection(feeCollectionName)
        .doc()
        .set(map);
  }

  Future<void> updateStudentFeeDetails(
      {required Map<String, dynamic> map,
      required String teacherCollectionName,
      required String teacherId,
      required String studentCollectionName,
      required String studentId,
      required String feeId}) async {
    return await FirebaseFirestore.instance
        .collection(teacherCollectionName)
        .doc(teacherId)
        .collection(studentCollectionName)
        .doc(studentId)
        .collection('student_fee')
        .doc(feeId)
        .update(map);
  }
}
