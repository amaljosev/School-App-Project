import 'dart:async';

import 'package:bloc/bloc.dart';

part 'admin_request_event.dart';
part 'admin_request_state.dart';

class AdminRequestBloc extends Bloc<AdminRequestEvent, AdminRequestState> {
  AdminRequestBloc() : super(AdminRequestInitial()) {
    on<ViewTeacherEvent>(viewTeacherEvent);
  }

  FutureOr<void> viewTeacherEvent(ViewTeacherEvent event, Emitter<AdminRequestState> emit) {
    emit(ViewTeacherState());
  }
}
