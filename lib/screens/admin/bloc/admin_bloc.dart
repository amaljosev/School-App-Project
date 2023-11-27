import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/firebase/admin/admin_db_functions.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<StudentCardTapEvent>(studentCardTapEvent);
    on<TeacherCardTapEvent>(teacherCardTapEvent);
    on<RequestTapEvent>(requestTapEvent);
    on<FloatingActionButtonTapEvent>(floatingActionButtonTapEvent);
    on<ShowAlertEvent>(showAlertEvent);
    on<CheckBoxTapEvent>(checkBoxTapEvent);
    on<LogOutEvent>(logOutEvent);
  }

  FutureOr<void> studentCardTapEvent(
      StudentCardTapEvent event, Emitter<AdminState> emit) {
    final Stream<QuerySnapshot<Object?>> studentList =
        AdminDb().getStudentsDatas(event.teacherId);
    emit(StudentCardTapState(
        studentList: studentList,
        standard: event.standard,
        division: event.division));
  }

  FutureOr<void> teacherCardTapEvent(
      TeacherCardTapEvent event, Emitter<AdminState> emit) {
    emit(TeacherCardTapState(teacherData: event.teacherData));
  }

  FutureOr<void> requestTapEvent(
      RequestTapEvent event, Emitter<AdminState> emit) {
    emit(RequestTapState());
  }

  FutureOr<void> floatingActionButtonTapEvent(
      FloatingActionButtonTapEvent event, Emitter<AdminState> emit) {
    emit(SettingsState());
  }

  FutureOr<void> checkBoxTapEvent(
      CheckBoxTapEvent event, Emitter<AdminState> emit) {
    emit(CheckboxSelectedState(isSelected: event.isSelected));
  }

  FutureOr<void> showAlertEvent(
      ShowAlertEvent event, Emitter<AdminState> emit) {
    emit(ShowWarningPopUpState());
  }

  FutureOr<void> logOutEvent(LogOutEvent event, Emitter<AdminState> emit) {
    emit(LogOutState());
  }
}
