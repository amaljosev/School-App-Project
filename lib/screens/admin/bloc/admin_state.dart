part of 'admin_bloc.dart';

abstract class AdminState {}

abstract class AdminActionState extends AdminState {}

final class AdminInitial extends AdminState {}

final class StudentCardTapState extends AdminActionState{} 

final class TeacherCardTapState extends AdminActionState{} 


