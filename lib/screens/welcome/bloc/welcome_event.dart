part of 'welcome_bloc.dart';

abstract class WelcomeEvent {}

abstract class WelcomeActionEvent extends WelcomeEvent {}

final class NavigateEvent extends WelcomeActionEvent {}

final class SignInButtonEvent extends WelcomeActionEvent {}

final class SignUpButtonEvent extends WelcomeActionEvent {
  final TeacherModel teacherData;
  SignUpButtonEvent({required this.teacherData});
} 
