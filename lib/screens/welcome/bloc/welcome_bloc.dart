import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<NavigateEvent>(navigate);
    on<SignInButtonEvent>(signInButtonEvent);
  }

  FutureOr<void> navigate(WelcomeEvent event, Emitter<WelcomeState> emit) {
    emit(NavigateToSignUpState());
  }

  FutureOr<void> signInButtonEvent(
      SignInButtonEvent event, Emitter<WelcomeState> emit) {
    emit(SignInSuccessState());
  }
}
