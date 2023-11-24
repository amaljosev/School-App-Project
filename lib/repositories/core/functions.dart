import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/screens/student/bloc/student_bloc.dart';
import 'package:schoolapp/screens/welcome/first_screen.dart';

Future<bool> tostudentHome(BuildContext context) async {
  context
      .read<StudentBloc>()
      .add(StudentBottomNavigationEvent(currentPageIndex: 0));
  return true;
}

FutureOr<void> logOut(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are You Sure !'),
        content: const Text(
          'Are you really want to log out?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenFirst(),
                ),
                (route) => false),
            child: const Text('Conform'),
          ),
          TextButton(
            child: const Text('Discard'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
