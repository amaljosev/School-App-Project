part of 'student_bloc.dart';

abstract class StudentState {}

abstract class StudentActionState extends StudentState {}

final class StudentInitial extends StudentState {}

final class StudentTileOpenState extends StudentActionState {
  final bool isExpanded;
  StudentTileOpenState({required this.isExpanded});
}

final class StudentTileCloseState extends StudentActionState {
    final bool isExpanded;
  StudentTileCloseState({required this.isExpanded}); 
}
