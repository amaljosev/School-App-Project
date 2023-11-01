import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/screens/student/widgets/student_fee_widget.dart';
import 'package:schoolapp/screens/teacher/profile/widgets/student_details_widget.dart';

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
        StudentDetailsWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Column(
            //   children: [
            //     StudentActionWidget(name: 'HW'),
            //     SizedBox(
            //       height: 20,
            //     ),
            //     StudentActionWidget(
            //       name: 'Assignment',
            //     ),
            //   ],
            // ),
            Column(
              children: [
                StudentFeeWidget(name: 'Fee Details'),
                SizedBox(
                  height: 20,
                ),
                // StudentActionWidget(name: 'Events'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
