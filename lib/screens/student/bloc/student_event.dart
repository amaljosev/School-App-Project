part of 'student_bloc.dart';

abstract class StudentEvent {}

abstract class StudentActionEvent extends StudentEvent {}

final class StudentBottomNavigationEvent extends StudentActionEvent{
  final int currentPageIndex;
  StudentBottomNavigationEvent({required this.currentPageIndex});
} 

final class StudentActionsEvent extends StudentActionEvent{
  final int index;
  StudentActionsEvent({required this.index}); 
}