import 'package:flutter/material.dart';
import 'package:schoolapp/screens/teacher/profile/widgets/student_feedetails_widget.dart';

Future<void> feePopupMessage(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: <Widget>[
          const StudentFeeDetailsWidget(isTeacher: false),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Discard'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
