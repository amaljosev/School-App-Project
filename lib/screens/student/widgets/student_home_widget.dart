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
                StudentFeeWidget(
                    name: 'Home Works',
                    index: 0,
                    assetPath: "lib/assets/images/hw.png"),
                SizedBox(
                  height: 20,
                ),
                StudentFeeWidget(
                    name: 'Fee Details',
                    index: 1,
                    assetPath: "lib/assets/images/fee.webp"),
              ],
            ),
            Column(
              children: [
                StudentFeeWidget(
                    name: 'Assignments',
                    index: 2,
                    assetPath: "lib/assets/images/assgnment.webp"),
                SizedBox(
                  height: 20,
                ),
                StudentFeeWidget(
                    name: 'Events',
                    index: 3,
                    assetPath: "lib/assets/images/notice.webp"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
