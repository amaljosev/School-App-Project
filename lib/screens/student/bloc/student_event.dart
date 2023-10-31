part of 'student_bloc.dart';

abstract class StudentEvent {}

abstract class StudentActionEvent extends StudentEvent {}

final class BottomNavigationEvent extends StudentEvent{
  final int currentPageIndex;
  BottomNavigationEvent({required this.currentPageIndex});
} 
