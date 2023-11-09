import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/widgets/button_widget.dart';

class StudentFeeDetailsWidget extends StatelessWidget {
  const StudentFeeDetailsWidget({
    super.key, required this.isTeacher,
  });
final bool isTeacher;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:isTeacher? appbarColor:null, 
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Fee Details',
              style: titleTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total Amount :',
                        style: contentTextStyle,
                      ),
                      Text(
                        'Amount Paid :',
                        style: contentTextStyle,
                      ),
                      Text(
                        'Amount Pending :',
                        style: contentTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' ₹25000',
                        style: contentTextStyle,
                      ),
                      Text(
                        ' ₹25000',
                        style: contentTextStyle,
                      ),
                      Text(
                        ' 0',
                        style: contentTextStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: ButtonSubmissionWidget(label: 'Edit', icon: Icons.edit),
            ),  
          ],
        ),
      ),
    );
  }
}