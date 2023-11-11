part of 'admin_bloc.dart';

abstract class AdminEvent {}

abstract class AdminActionEvent extends AdminEvent {}

final class StudentCardTapEvent extends AdminActionEvent {
  final String teacherId;
  StudentCardTapEvent({required this.teacherId}); 
}

final class TeacherCardTapEvent extends AdminActionEvent {
  final Map<String, dynamic> teacherData;
  TeacherCardTapEvent({required this.teacherData});
}

final class RequestTapEvent extends AdminActionEvent {}


