import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<BottomNavigationEvent>(bottomNavigationEvent);
  }

  FutureOr<void> bottomNavigationEvent(
      BottomNavigationEvent event, Emitter<StudentState> emit) {
    emit(BottomNavigationState(currentPageIndex: event.currentPageIndex));
  }
}
