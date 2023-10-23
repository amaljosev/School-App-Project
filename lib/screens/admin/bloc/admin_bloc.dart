import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/firebase/admin/signup_admin_functions.dart'; 


part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<StudentCardTapEvent>(studentCardTapEvent);
    on<TeacherCardTapEvent>(teacherCardTapEvent);
    on<RequestTapEvent>(requestTapEvent);
    on<AcceptButtonEvent>(acceptButtonEvent);
  }

  FutureOr<void> studentCardTapEvent(StudentCardTapEvent event, Emitter<AdminState> emit) {
    emit(StudentCardTapState()); 
  }

  FutureOr<void> teacherCardTapEvent(TeacherCardTapEvent event, Emitter<AdminState> emit) {
    emit(TeacherCardTapState()); 
  }

  FutureOr<void> requestTapEvent(RequestTapEvent event, Emitter<AdminState> emit) {
    emit(RequestTapState());
  }

  FutureOr<void> acceptButtonEvent(AcceptButtonEvent event, Emitter<AdminState> emit) {
    AdminActions().acceptRequest(event.id);
    emit(AcceptRequestState()); 
  }
}
