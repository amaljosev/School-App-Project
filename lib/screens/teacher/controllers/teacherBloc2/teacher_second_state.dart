part of 'teacher_second_bloc.dart';

abstract class TeacherSecondState {}

final class TeacherSecondInitial extends TeacherSecondState {}

final class TeacherSecondActionState extends TeacherSecondState {}

final class CheckBoxTapState extends TeacherSecondActionState {
  final bool? isChecked;
  final int index;
  CheckBoxTapState({required this.isChecked, required this.index});
}

final class SubmitAttendanceSuccessState extends TeacherSecondActionState {}

final class SubmitAttendanceLoadingState extends TeacherSecondActionState {}

final class SubmitAttendanceErrorState extends TeacherSecondActionState {}

final class FetchAttendanceHistorySuccessState
    extends TeacherSecondActionState {
  final Stream<QuerySnapshot<Object?>> attendenceHistory;
  FetchAttendanceHistorySuccessState({required this.attendenceHistory});
}

final class FetchAttendanceHistoryLoadingState
    extends TeacherSecondActionState {}

final class FetchAttendanceHistoryErrorState extends TeacherSecondActionState {}
