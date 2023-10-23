part of 'admin_bloc.dart';

abstract class AdminEvent {}

abstract class AdminActionEvent extends AdminEvent {}

final class StudentCardTapEvent extends AdminActionEvent {}

final class TeacherCardTapEvent extends AdminActionEvent {}

final class RequestTapEvent extends AdminActionEvent {}