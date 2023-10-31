part of 'student_bloc.dart';

abstract class StudentState {}

abstract class StudentActionState extends StudentState {}

final class StudentInitial extends StudentState {}

final class BottomNavigationState extends StudentActionState {
  final int currentPageIndex;
  BottomNavigationState({required this.currentPageIndex});
}
