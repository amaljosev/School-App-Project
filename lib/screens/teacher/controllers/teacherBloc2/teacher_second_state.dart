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

final class EditTeacherSuccessState extends TeacherSecondActionState {
  final TeacherModel teacherData;
  EditTeacherSuccessState({required this.teacherData});
}

// final class FetchHomeWorkErrorDatas extends TeacherSecondActionState {}

// final class FetchHomeWorkSuccessDatas extends TeacherSecondActionState {
//   final Stream<QuerySnapshot<Object?>> homeWorksData;
//   FetchHomeWorkSuccessDatas({required this.homeWorksData});
// }

// final class FetchHomeWorkLoadingDatas extends TeacherSecondActionState {}

// final class FetchAssignmentErrorDatas extends TeacherSecondActionState {}

// final class FetchAssignmentSuccessDatas extends TeacherSecondActionState {
//   final Stream<QuerySnapshot<Object?>> assignmentsData;
//   FetchAssignmentSuccessDatas({required this.assignmentsData});
// }

// final class FetchAssignmentLoadingDatas extends TeacherSecondActionState {}






final class FetchTaskErrorDatas extends TeacherSecondActionState {}

final class FetchTaskSuccessDatas extends TeacherSecondActionState {
  final Stream<QuerySnapshot<Object?>> taskData;
  FetchTaskSuccessDatas({required this.taskData});
}

final class FetchTaskLoadingDatas extends TeacherSecondActionState {}
