part of 'teacher_second_bloc.dart';

abstract class TeacherSecondEvent {}

final class TeacherSecondActionEvent extends TeacherSecondEvent {}

final class CheckBoxTapEvent extends TeacherSecondActionEvent {
  final bool? isChecked;
  final int index;
  CheckBoxTapEvent({required this.isChecked, required this.index});
}

final class SubmitAttendanceEvent extends TeacherSecondActionEvent {
  final List<DocumentSnapshot> students;
  final List<bool?> checkMarks;
  SubmitAttendanceEvent({required this.checkMarks, required this.students});
}

final class UpdateAttendanceEvent extends TeacherSecondActionEvent {
  final List<DocumentSnapshot> students;
  final List<bool?> checkMarks;
  UpdateAttendanceEvent({required this.checkMarks, required this.students});
}

final class FetchAttendanceHistoryEvent extends TeacherSecondActionEvent {}

final class HomeWorkSendEvent extends TeacherSecondActionEvent {
  String task;
  String subject;
  HomeWorkSendEvent({required this.task, required this.subject});
}

final class DateSelectedEvent extends TeacherSecondActionEvent {
  final DateTime selectedDate;
  DateSelectedEvent({required this.selectedDate});
}

final class AssignmentSendEvent extends TeacherSecondActionEvent {
  String task;
  String subject;
  DateTime selectedDate;
  AssignmentSendEvent(
      {required this.task, required this.subject, required this.selectedDate});
}

final class TaskDropDownEvent extends TeacherSecondActionEvent {
  int index;
  String? value;
  TaskDropDownEvent({required this.index, required this.value});
}

final class LogoutEvent extends TeacherSecondActionEvent {}

final class EditTeacherEvent extends TeacherSecondActionEvent {
  final TeacherModel teacherData;
  EditTeacherEvent({required this.teacherData});
}

final class FetchHomeWorkDatasEvent extends TeacherSecondActionEvent{}