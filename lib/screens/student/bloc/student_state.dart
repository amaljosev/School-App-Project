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
  final String name;
  StudentActionsState({required this.index, required this.name});
}

final class FetchStudentDatasSuccessState extends StudentActionState {
  final Stream<DocumentSnapshot<Object?>> studentstream;
  final String studentId;
  final int totalWorkingDaysCompleted;
  FetchStudentDatasSuccessState(
      {required this.studentstream,
      required this.studentId,
      required this.totalWorkingDaysCompleted});
}

final class FetchEventsDatasSuccessDatas extends StudentActionState {
  final Stream<QuerySnapshot<Object?>> eventsData;
  FetchEventsDatasSuccessDatas({required this.eventsData});
}

final class FetchEventsDatasLoadingState extends StudentActionState {}

final class FetchEventsDatasErrorState extends StudentActionState {}

final class SubmitWorkSuccessState extends StudentActionState {}

final class SubmitWorkLoadingState extends StudentActionState {}

final class SubmitWorkErrorState extends StudentActionState {}
