 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/screens/student/bloc/student_bloc.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';

Future<bool> toTeacherHome(BuildContext context) async{
  context.read<TeacherBloc>().add(BottomNavigationEvent(currentPageIndex: 0));
  return true; 
}
Future<bool> tostudentHome(BuildContext context) async{
  context.read<StudentBloc>().add(StudentBottomNavigationEvent(currentPageIndex: 0)); 
  return true; 
}