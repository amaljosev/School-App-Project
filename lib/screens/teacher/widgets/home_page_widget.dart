import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/teacher/widgets/calender_widget.dart';
import 'package:schoolapp/screens/teacher/widgets/class_details.dart';
import 'package:schoolapp/screens/teacher/widgets/teacher_bottom.dart';
import 'package:schoolapp/screens/teacher/widgets/teacher_studentlist.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CalenderWidget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClassDetailsWidget(size: size),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            child: Text(
              'Students',
              style: titleTextStyle  
            ),
          ),
          const TeacherStudentsList(),
          TeacherActions(size: size),
        ],
      ),
    );
  }
}