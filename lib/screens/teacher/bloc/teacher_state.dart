part of 'teacher_bloc.dart';

abstract class TeacherState {}

abstract class TeacherActionState extends TeacherState {}

final class TeacherInitial extends TeacherState {}

final class FormStudentState extends TeacherActionState {} 

final class AddStudentState extends TeacherActionState {}  
