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

final class UpdateAttendanceSuccessState extends TeacherSecondActionState {}

final class UpdateAttendanceLoadingState extends TeacherSecondActionState {}

final class UpdateAttendanceErrorState extends TeacherSecondActionState {}

final class FetchAttendanceHistorySuccessState
    extends TeacherSecondActionState {
  final Stream<QuerySnapshot<Object?>> attendenceHistory;
  FetchAttendanceHistorySuccessState({required this.attendenceHistory});
}

final class FetchAttendanceHistoryLoadingState
    extends TeacherSecondActionState {}

final class FetchAttendanceHistoryErrorState extends TeacherSecondActionState {}

final class HomeWorkSendSuccessState extends TeacherSecondActionState {}

final class HomeWorkSendLoadingState extends TeacherSecondActionState {}

final class HomeWorkSendErrorState extends TeacherSecondActionState {}

final class HomeWorkDropDownState extends TeacherSecondActionState {
  int index;
  String? value;
  HomeWorkDropDownState({required this.index, required this.value});
}

final class DateSelectedState extends TeacherSecondActionState {
  final DateTime selectedDate;
  DateSelectedState({required this.selectedDate});
}

final class AssignmentSendSuccessState extends TeacherSecondActionState {}

final class AssignmentSendLoadingState extends TeacherSecondActionState {}

final class AssignmentSendErrorState extends TeacherSecondActionState {}

final class LogoutState extends TeacherSecondActionState {}
