part of 'welcome_bloc.dart';

abstract class WelcomeState {}

abstract class WelcomeActionState extends WelcomeState {}

final class WelcomeInitial extends WelcomeState {}

final class NavigateToSignUpState extends WelcomeActionState {}

final class SignInSuccessState extends WelcomeActionState {}

final class SignInErrorState extends WelcomeActionState {}
