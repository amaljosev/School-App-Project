import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<StudentBottomNavigationEvent>(bottomNavigationEvent);
    on<StudentActionsEvent>(studentActionsEvent);
  }

  FutureOr<void> bottomNavigationEvent(
      StudentBottomNavigationEvent event, Emitter<StudentState> emit) {
    emit(StudentBottomNavigationState(currentPageIndex: event.currentPageIndex)); 
  }

  FutureOr<void> studentActionsEvent(StudentActionsEvent event, Emitter<StudentState> emit) {
    emit(StudentActionsState(
      index: event.index
    ));
  }
}
