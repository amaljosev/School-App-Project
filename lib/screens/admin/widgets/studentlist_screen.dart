import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenStudentList extends StatelessWidget {
  const ScreenStudentList({
    super.key,
    required this.studentData,
  });
  final Stream<QuerySnapshot<Object?>> studentData;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrange,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<DocumentSnapshot> students = snapshot.data!.docs;
            return Scaffold(
              appBar: myAppbar('class 1'),
              body: SafeArea(
                child: SizedBox.expand(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot student = students[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ExpansionTile(
                          collapsedBackgroundColor: appbarColor,
                          backgroundColor: appbarColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(student['gender']=='Gender.male' 
                                ? 'lib/assets/images/student male.jpg'
                                : 'lib/assets/images/student female.png'),
                          ),
                          title: Text(
                            "${student['first_name']}",
                            style: titleTextStyle,
                          ),
                          childrenPadding: const EdgeInsets.all(8),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'class : '"${student['standard']}",  
                                            style: contentTextStyle,
                                          ),
                                          Text( 
                                            'class teacher : '"${student['class_Teacher']}",
                                            style: contentTextStyle,
                                          ),
                                          Text(
                                            'contact : '"${student['contact_no']}", 
                                            style: contentTextStyle,
                                          ),
                                          Text(
                                            'age : '"${student['age']}", 
                                            style: contentTextStyle,
                                          ),
                                        ], 
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox(
              child: Center(child: Text('Something went wrong')),
            );
          }
        });
  }
}
