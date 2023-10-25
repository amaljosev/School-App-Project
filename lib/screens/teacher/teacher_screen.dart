import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/screens/teacher/widgets/calender_widget.dart';
import 'package:schoolapp/screens/teacher/widgets/class_details.dart';
import 'package:schoolapp/screens/teacher/widgets/teacher_bottom.dart';
import 'package:schoolapp/screens/teacher/widgets/teacher_studentlist.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenTeacher extends StatelessWidget {
  const ScreenTeacher({super.key});

  @override
  Widget build(BuildContext context) { 
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppbar('Teacher'),
      body: SingleChildScrollView(
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
              child: Text('Students',
                  style: GoogleFonts.tiltNeon(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: headingColor)),
            ),
            const TeacherStudentsList(),
            TeacherActions(size: size),
          ],
        ),
      ),
    );
  }
}
