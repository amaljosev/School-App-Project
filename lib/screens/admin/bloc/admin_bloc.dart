import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<StudentCardTapEvent>(studentCardTapEvent);
    on<TeacherCardTapEvent>(teacherCardTapEvent);
    on<RequestTapEvent>(requestTapEvent);
   
  }

  FutureOr<void> studentCardTapEvent(StudentCardTapEvent event, Emitter<AdminState> emit) {
    emit(StudentCardTapState()); 
  }

  FutureOr<void> teacherCardTapEvent(TeacherCardTapEvent event, Emitter<AdminState> emit) {
    emit(TeacherCardTapState(
      teacherData: event.teacherData
    )); 
  }

  FutureOr<void> requestTapEvent(RequestTapEvent event, Emitter<AdminState> emit) {
    emit(RequestTapState());
  }

 
}
