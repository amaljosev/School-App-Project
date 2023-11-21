import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/screens/student/bloc/student_bloc.dart';
Future<bool> tostudentHome(BuildContext context) async {
  context
      .read<StudentBloc>()
      .add(StudentBottomNavigationEvent(currentPageIndex: 0));
  return true;
}

