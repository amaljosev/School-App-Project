part of 'student_bloc.dart';

abstract class StudentEvent {}

abstract class StudentActionEvent extends StudentEvent {}

final class StudentBottomNavigationEvent extends StudentActionEvent {
  final int currentPageIndex;
  StudentBottomNavigationEvent({required this.currentPageIndex});
}

final class StudentActionsEvent extends StudentActionEvent {
  final int index;
  StudentActionsEvent({required this.index});
}

final class FetchStudentDataEvent extends StudentActionEvent {}

final class UpdateStudentDataStudentEvent extends StudentActionEvent {
  final StudentModel studentData;
  final String studentId; 
  UpdateStudentDataStudentEvent({required this.studentData, required this.studentId});
}
