import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/screens/admin/bloc/admin_bloc.dart';

class TeacherCardWidget extends StatelessWidget {
  const TeacherCardWidget({
    super.key,
    required this.teachersList,
  });

  final List teachersList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: teachersList.length,
        itemBuilder: (context, index) {
          DocumentSnapshot document = teachersList[index];
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          String teacherName = data['name'];
          return GestureDetector(
            onTap: () => context
                .read<AdminBloc>()
                .add(TeacherCardTapEvent(teacherData: data)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                        color: teacherListColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: scaffoldColor,
                      backgroundImage:
                          const AssetImage('lib/assets/images/teacher.jpg'),
                    ),
                  ),
                  Positioned(
                      bottom: 55,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 65,
                          width: 130,
                          decoration: BoxDecoration(
                              color: scaffoldColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  'Name : $teacherName',
                                  style: const TextStyle(
                                      color: headingColor,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "Class : ${data['class']}",
                                style: const TextStyle(
                                    color: headingColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}