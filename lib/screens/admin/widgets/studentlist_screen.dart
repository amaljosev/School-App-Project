import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/widgets/my_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenStudentList extends StatelessWidget {
  const ScreenStudentList({
    super.key,
    required this.studentData,
    required this.standard, required this.division,
  });
  final Stream<QuerySnapshot<Object?>> studentData;
  final String standard;
  final String division;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Container(
              color: scaffoldColor, 
              child: const Center( 
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<DocumentSnapshot> students = snapshot.data!.docs;
            return Scaffold(
              appBar: myAppbar('class $standard-$division'),
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
                            backgroundImage: AssetImage(
                                student['gender'] == 'Gender.male'
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
                                            "Gurdian's Name ",
                                            style: contentTextStyle,
                                          ),
                                          Text(
                                            'class teacher ',
                                            style: contentTextStyle,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'contact ',
                                                style: contentTextStyle,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Register No ',
                                            style: contentTextStyle,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ": ${student['guardian_name']}",
                                            style: contentTextStyle,
                                          ),
                                          Text(
                                            ": ${student['class_Teacher']}",
                                            style: contentTextStyle,
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  final Uri url = Uri(
                                                      scheme: 'tel',
                                                      path:
                                                          ": ${student['contact_no']}");
                                                  if (await canLaunchUrl(url)) {
                                                    await launchUrl(url);
                                                  } else {
                                                    log("can't call");
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      ': ',
                                                      style: contentTextStyle,
                                                    ),
                                                    Text(
                                                      "${student['contact_no']}",
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: contentColor,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              contentColor),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            ": ${student['register_no']}",
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
