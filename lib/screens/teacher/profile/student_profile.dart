import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';
import 'package:schoolapp/screens/teacher/profile/widgets/student_attendence_widget.dart';
import 'package:schoolapp/screens/teacher/profile/widgets/profile_head_widget.dart';
import 'package:schoolapp/screens/teacher/profile/widgets/student_details_widget.dart';
import 'package:schoolapp/screens/teacher/profile/widgets/student_feedetails_widget.dart';

class ScreenStudentProfileTeacher extends StatelessWidget {
  const ScreenStudentProfileTeacher(
      {super.key, required this.studentsMap, required this.studentFee});
  final Map<String, dynamic> studentsMap;
  final CollectionReference<Map<String, dynamic>> studentFee;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              context
                  .read<TeacherBloc>()
                  .add(BottomNavigationEvent(currentPageIndex: 0));
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          'Student Profile',
          style: appbarTextStyle,
        ),
        backgroundColor: appbarColor,
      ),
      body: WillPopScope(
        onWillPop: () => toTeacherHome(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileHeadWidget(
                  image: 'lib/assets/images/student female.png',
                  name:
                      "${studentsMap['first_name']} ${studentsMap['second_name']}"),
              StudentDetailsWidget(isTeacher: true, students: studentsMap),
              SizedBox(
                  height: size.height * 0.40,
                  child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 10), 
                      scrollDirection: Axis.horizontal,
                      children: [
                        StudentAttendenceDetailsWidget(size: size),
                        const SizedBox(
                          width: 10,
                        ),
                        StudentFeeDetailsWidget(
                            isTeacher: true, studentFee: studentFee),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
