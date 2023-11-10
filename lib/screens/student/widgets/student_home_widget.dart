import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/screens/student/widgets/student_fee_widget.dart';

class StudentHomeWidget extends StatelessWidget {
  const StudentHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: CircleAvatar(
            backgroundColor: headingColor,
            radius: 60,
            child: CircleAvatar(
              radius: 55,
              backgroundImage:
                  AssetImage('lib/assets/images/student female.png'),
            ),
          ),
        ),
        // StudentDetailsWidget(isTeacher: false),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                StudentFeeWidget(name: 'HW',index: 0),
                SizedBox(
                  height: 20,
                ),
                StudentFeeWidget(name: 'Fee Details',index: 1),
              ],
            ),
            Column(
              children: [
                StudentFeeWidget(name: 'Assignments',index: 2),
                SizedBox(
                  height: 20,
                ),
                StudentFeeWidget(name: 'Events',index: 3), 
              ],
            ),
          ],
        ),
      ],
    );
  }
}
