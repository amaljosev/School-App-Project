import 'package:cloud_firestore/cloud_firestore.dart';

class DbFunctions {
    Future<void> addrDetails(Map<String, dynamic> map,String collectionName) async {
    return await FirebaseFirestore.instance
        .collection(collectionName) 
        .doc()  
        .set(map);
  }
  
}