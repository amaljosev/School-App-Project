part of 'teacher_bloc.dart';

abstract class TeacherEvent {}

abstract class TeacherActionEvent extends TeacherEvent {}

final class HomeEvent extends TeacherActionEvent {}

final class FormStudentEvent extends TeacherActionEvent {}

final class AddStudentEvent extends TeacherActionEvent {
  StudentModel studentData;
  AddStudentEvent({required this.studentData});
}

final class AttendenceEvent extends TeacherActionEvent {}

final class StudentProfileEvent extends TeacherActionEvent {}

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

final class DropdownTeacherEvent extends TeacherActionEvent {
  final String? dropdownValue;
  final int onSelected;
  DropdownTeacherEvent({
    required this.dropdownValue,
    required this.onSelected,
  });
}
final class RadioButtonEvent extends TeacherActionEvent{
  final Gender? gender;
  RadioButtonEvent({required this.gender});
}
