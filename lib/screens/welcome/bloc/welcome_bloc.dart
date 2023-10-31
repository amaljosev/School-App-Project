import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/models/teacher_model.dart';
import 'package:schoolapp/repositories/firebase/admin/signup_request.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

SignUpRequest signUpRequest = SignUpRequest();

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<NavigateEvent>(navigate);
    on<SignInButtonEvent>(signInButtonEvent);
    on<SignUpButtonEvent>(signUpButtonEvent);
    on<DropdownMenuTapEvent>(dropdownMenuTapEvent);
  }

  FutureOr<void> navigate(WelcomeEvent event, Emitter<WelcomeState> emit) {
    emit(NavigateToSignUpState());
  }

  FutureOr<void> signInButtonEvent(
      SignInButtonEvent event, Emitter<WelcomeState> emit) {
    emit(SignInSuccessState());
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
}
