import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/screens/student/widgets/student_fee_widget.dart';
import 'package:schoolapp/screens/teacher/profile/widgets/student_details_widget.dart';

class StudentHomeWidget extends StatelessWidget {
  const StudentHomeWidget({
    super.key,
    required this.studentId,
    required this.students,
  });
  final String studentId;
  final Map<String, dynamic> students;
  @override
  Widget build(BuildContext context) {
    final gender = students['gender'];
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),  
          child: CircleAvatar(
            backgroundColor: headingColor,
            radius: 60,
            child: CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage(gender == 'Gender.male'
                  ? 'lib/assets/images/student male.jpg'
                  : 'lib/assets/images/student female.png'),
            ),
          ),
        ),
        StudentDetailsWidget(
          isTeacher: false,
          studentId: studentId,
          students: students,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                StudentFeeWidget(name: 'HW', index: 0),
                SizedBox(
                  height: 20,
                ),
                StudentFeeWidget(name: 'Fee Details', index: 1),
              ],
            ),
            Column(
              children: [
                StudentFeeWidget(name: 'Assignments', index: 2),
                SizedBox(
                  height: 20,
                ),
                StudentFeeWidget(name: 'Events', index: 3),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
