part of 'student_bloc.dart';

abstract class StudentEvent {}

abstract class StudentActionEvent extends StudentEvent {}

final class StudentTileTapEvent extends StudentActionEvent{
  final bool isExpanded;
  StudentTileTapEvent({required this.isExpanded});
}  

