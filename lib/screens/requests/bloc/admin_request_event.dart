part of 'admin_request_bloc.dart';

abstract class AdminRequestEvent {}

abstract class AdminRequestActionEvent extends AdminRequestEvent {}

final class ViewTeacherEvent extends AdminRequestActionEvent{} 
