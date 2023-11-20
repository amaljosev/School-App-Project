part of 'student_bloc.dart';

abstract class StudentState {}

abstract class StudentActionState extends StudentState {}

final class StudentInitial extends StudentState {}

final class StudentBottomNavigationState extends StudentActionState {
  final int currentPageIndex;
  StudentBottomNavigationState({required this.currentPageIndex});
}

final class StudentActionsState extends StudentActionState {
  final int index;
  StudentActionsState({required this.index});
}

final class FetchStudentDatasSuccessState extends StudentActionState {
  final Stream<DocumentSnapshot<Object?>> studentstream;
  final String studentId;
  final int totalWorkingDaysCompleted;
  FetchStudentDatasSuccessState(
      {required this.studentstream, required this.studentId,required this.totalWorkingDaysCompleted});
}

final class UpdateStudentDataSuccessState extends StudentActionState {}

final class UpdateStudentDataErrorState extends StudentActionState {}

final class UpdateStudentDataLoadingState extends StudentActionState {}
