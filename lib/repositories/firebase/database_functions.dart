import 'package:cloud_firestore/cloud_firestore.dart';

class DbFunctions {
  Future<void> addDetails(
      Map<String, dynamic> map, String collectionName,String id) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .set(map); 
  }

  Future<void> addClassDetails(Map<String, dynamic> map,  
      String collectionName,String teacherId, String subCollectionName) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(teacherId) 
        .collection(subCollectionName)
        .doc()
        .set(map);
  }

  Future<void> addStudentDetails(Map<String, dynamic> map,
      String collectionName,String teacherId, String subCollectionName) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(teacherId) 
        .collection(subCollectionName)
        .doc()
        .set(map);
  }
}
