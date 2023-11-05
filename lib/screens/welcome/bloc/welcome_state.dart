part of 'welcome_bloc.dart';

abstract class WelcomeState {}

abstract class WelcomeActionState extends WelcomeState {}

final class WelcomeInitial extends WelcomeState {}

final class SplashState extends WelcomeState {}

final class NavigateToSignUpState extends WelcomeActionState {}

final class SignUpSuccessState extends WelcomeActionState {}

final class SignUpErrorState extends WelcomeActionState {}

final class SignInSuccessState extends WelcomeActionState {}

final class SignInErrorState extends WelcomeActionState {}

final class DropdownMenuTapState extends WelcomeActionState {
  final String? dropdownValue;
  final int index;

  DropdownMenuTapState({
    required this.dropdownValue,
    required this.index,
  });
}

final class LoginCompletedState extends WelcomeActionState {}

final class AdminLoginState extends WelcomeActionEvent {}

final class NewUserState extends WelcomeActionState {}

final class TeacherLoginState extends WelcomeActionState{
  final bool isTeacher;
  TeacherLoginState({required this.isTeacher});
}

final class StudentLoginState extends WelcomeActionState{
  final bool isTeacher;
  StudentLoginState({required this.isTeacher});
}