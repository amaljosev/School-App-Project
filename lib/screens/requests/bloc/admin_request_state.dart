part of 'admin_request_bloc.dart';

abstract class AdminRequestState {}

abstract class AdminRequestActionState extends AdminRequestState {}

final class AdminRequestInitial extends AdminRequestState {}

final class ViewTeacherState extends AdminRequestActionState{}
