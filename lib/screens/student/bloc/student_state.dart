part of 'student_bloc.dart';

abstract class StudentState {}

abstract class StudentActionState extends StudentState {}

final class StudentInitial extends StudentState {}

final class StudentBottomNavigationState extends StudentActionState {
  final int currentPageIndex;
  StudentBottomNavigationState({required this.currentPageIndex});
}
final class StudentActionsState extends StudentActionState{
  final int index;
  StudentActionsState({required this.index});
} 