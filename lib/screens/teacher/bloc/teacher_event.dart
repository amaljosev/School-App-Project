part of 'teacher_bloc.dart';

abstract class TeacherEvent {}

abstract class TeacherActionEvent extends TeacherEvent {}

final class HomeEvent extends TeacherActionEvent {}

final class FormStudentEvent extends TeacherActionEvent {}

final class AddStudentEvent extends TeacherActionEvent {
  FeeModel feeData;
  StudentModel studentData;
  ClassModel classDatas;
  AddStudentEvent(
      {required this.studentData, 
      required this.classDatas,
      required this.feeData});
}

final class AttendenceEvent extends TeacherActionEvent {}

final class StudentProfileEvent extends TeacherActionEvent {
  final Map<String, dynamic> students;
  final CollectionReference<Map<String, dynamic>> studentFee;
  StudentProfileEvent({required this.students,required this.studentFee}); 
}

final class BottomNavigationEvent extends TeacherActionEvent {
  int currentPageIndex;
  BottomNavigationEvent({
    required this.currentPageIndex,
  });
}

final class SchoolEventsEvent extends TeacherActionEvent {}

final class TeacherAssignmentEvent extends TeacherActionEvent {}

final class TeacherHomeWorkEvent extends TeacherActionEvent {}

final class TeacherLeaveApplicationEvent extends TeacherActionEvent {}

final class FetchTeacherDatasEvent extends TeacherActionEvent {}

final class RadioButtonEvent extends TeacherActionEvent {
  final Gender? gender;
  RadioButtonEvent({required this.gender});
}

final class FetchStudentDatasEvent extends TeacherActionEvent {}

final class FetchClassDetailsEvent extends TeacherActionEvent {}
