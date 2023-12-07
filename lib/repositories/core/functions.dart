// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:schoolapp/screens/welcome/first_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

FutureOr<void> studentLogOut(BuildContext context) {
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
            onPressed: () async {
              final sharedPrefs = await SharedPreferences.getInstance();
              await sharedPrefs.setBool('user_login', false);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenFirst(),
                  ),
                  (route) => false);
            },
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

FutureOr<void> teacherLogOut(BuildContext context) {
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
            onPressed: () async {
              final sharedPrefs = await SharedPreferences.getInstance();
              await sharedPrefs.setBool('user_login', false);
              await sharedPrefs.setBool('admin_login', false);
              await sharedPrefs.setBool('is_teacher', false);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenFirst(),
                  ),
                  (route) => false);
            },
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

FutureOr<void> adminLogOut(BuildContext context) {
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
            onPressed: () async {
              final sharedPrefs = await SharedPreferences.getInstance();
              await sharedPrefs.setBool('user_login', false);
              await sharedPrefs.setBool('admin_login', false);
              await sharedPrefs.setBool('is_teacher', false);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenFirst(),
                  ),
                  (route) => false);
            },
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
