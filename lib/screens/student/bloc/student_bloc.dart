import 'dart:async';

import 'package:bloc/bloc.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<StudentTileTapEvent>(studentTileTapEvent);
  }

  FutureOr<void> studentTileTapEvent(
      StudentTileTapEvent event, Emitter<StudentState> emit) {
    final bool isExpanded = event.isExpanded;
    if (isExpanded) {
      emit(StudentTileOpenState(isExpanded: event.isExpanded));
    } else {
      emit(StudentTileCloseState(isExpanded: event.isExpanded));
    }
  }
}
