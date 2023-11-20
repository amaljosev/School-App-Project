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
  SubmitAttendanceEvent({required this.checkMarks,required this.students});
}
