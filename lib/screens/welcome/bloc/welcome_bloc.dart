import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/models/teacher_model.dart';
import 'package:schoolapp/repositories/firebase/admin/signup_request.dart';
import 'package:schoolapp/repositories/firebase/login/login_functions.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

SignUpRequest signUpRequest = SignUpRequest();

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<NavigateEvent>(navigate);
    on<SignInButtonEvent>(signInButtonEvent);
    on<SignUpButtonEvent>(signUpButtonEvent);
    on<DropdownMenuTapEvent>(dropdownMenuTapEvent);
    on<SplashEvent>(splashEvent);
    on<SplashCompleteEvent>(splashCompleteEvent);
    on<TeacherLoginEvent>(teacherLoginEvent);
    on<StudentLoginEvent>(studentLoginEvent);
  }
  FutureOr<void> splashEvent(SplashEvent event, Emitter<WelcomeState> emit) {
    emit(SplashState());
  }

  FutureOr<void> navigate(WelcomeEvent event, Emitter<WelcomeState> emit) {
    emit(NavigateToSignUpState());
  }

  FutureOr<void> signInButtonEvent(
      SignInButtonEvent event, Emitter<WelcomeState> emit) async {
    final userExist =
        await LoginFunctions().loginUser(event.email, event.password);
    if (userExist) {
      emit(SignInSuccessState());
    } else {
      emit(SignInErrorState());
    }
  }

  FutureOr<void> signUpButtonEvent(
      SignUpButtonEvent event, Emitter<WelcomeState> emit) async {
    final classExist =
        await SignUpRequest().checkClass(event.teacherData.className);

    if (classExist) {
      emit(SignUpErrorState());
    } else {
      signUpRequest.addData(event.teacherData);
      emit(SignUpSuccessState());
    }
  }

  FutureOr<void> dropdownMenuTapEvent(
      DropdownMenuTapEvent event, Emitter<WelcomeState> emit) {
    emit(DropdownMenuTapState(
        dropdownValue: event.dropdownValue, index: event.onSelected));
  }

  FutureOr<void> splashCompleteEvent(
      SplashCompleteEvent event, Emitter<WelcomeState> emit) {
    emit(NewUserState());
  }

  FutureOr<void> teacherLoginEvent(
      TeacherLoginEvent event, Emitter<WelcomeState> emit) {
    emit(TeacherLoginState(isTeacher: event.isTeacher));
  }

  FutureOr<void> studentLoginEvent(
      StudentLoginEvent event, Emitter<WelcomeState> emit) {
    emit(StudentLoginState(isTeacher: event.isTeacher));
  }
}
