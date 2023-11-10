import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/functions.dart';

class AlertDialogWidgets {
  Future<void> addStudentMessage(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Saved'),
          titleTextStyle: const TextStyle(color: Colors.green),
          content: const Text('Student Profile Created Successfully'), 
          actions: <Widget>[
            ElevatedButton( 
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Home'),
              onPressed: () {
                 Navigator.of(context).popUntil((route) => route.isFirst); 
                  toTeacherHome(context); 
              },
            ),
            ElevatedButton(
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
}
