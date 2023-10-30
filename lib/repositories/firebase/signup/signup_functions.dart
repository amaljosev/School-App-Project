import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpDbFunctions {
  final CollectionReference classCollection =
      FirebaseFirestore.instance.collection('classes');
  Stream<QuerySnapshot> getClasses() {
    final teachersStream = classCollection.snapshots();

    return teachersStream;
  }

  
}
