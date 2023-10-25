part of 'teacher_bloc.dart';

abstract class TeacherEvent {}

abstract class TeacherActionEvent extends TeacherEvent {}

final class FormStudentEvent extends TeacherActionEvent {}

final class AddStudentEvent extends TeacherActionEvent {
  StudentModel studentData;
  AddStudentEvent({required this.studentData});
}
