import 'package:cloud_firestore/cloud_firestore.dart';

class DbFunctions {
  Future<void> addrDetails(
      Map<String, dynamic> map, String collectionName) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
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
