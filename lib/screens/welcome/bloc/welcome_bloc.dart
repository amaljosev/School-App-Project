import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/screens/models/teacher_model.dart';
import 'package:schoolapp/screens/welcome/widgets/firestore_services.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

FireStoreServices fireStoreService = FireStoreServices();

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitial()) {
    on<NavigateEvent>(navigate);
    on<SignUpButtonEvent>(signUpButtonEvent);
    on<SignInButtonEvent>(signInButtonEvent);
  }

  FutureOr<void> navigate(WelcomeEvent event, Emitter<WelcomeState> emit) {
    emit(NavigateToSignUpState());
  }

  FutureOr<void> signInButtonEvent(
      SignInButtonEvent event, Emitter<WelcomeState> emit) {
    emit(SignInSuccessState());
  }

  FutureOr<void> signUpButtonEvent(
      SignUpButtonEvent event, Emitter<WelcomeState> emit) {
    fireStoreService.addData (event.teacherData); 
    emit(SignInSuccessState());
  }
}
