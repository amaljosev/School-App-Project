import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/widgets/button_widget.dart';

class StudentFeeDetailsWidget extends StatelessWidget {
  const StudentFeeDetailsWidget({
    Key? key,
    required this.isTeacher,
    required this.studentFee,
  }) : super(key: key);

  final bool isTeacher;
  final CollectionReference<Map<String, dynamic>> studentFee;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: studentFee.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(color: Colors.pink);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final feeData = snapshot.data!.docs.first.data();

          return Container(
            decoration: BoxDecoration(
              color: isTeacher ? appbarColor : null,
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
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' ₹${feeData['total_amount']}',
                              style: contentTextStyle,
                            ),
                            Text(
                              ' ₹${feeData['amount_paid']}', 
                              style: contentTextStyle,
                            ),
                            Text(
                              ' ₹${feeData['amount_pending']}',
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
        } else {
          return const SizedBox(
            child: Center(child: Text('Something went wrong')),
          );
        }
      },
    );
  }
}

