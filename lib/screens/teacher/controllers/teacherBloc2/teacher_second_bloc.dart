import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/firebase/teacher/attendance_functions.dart';
import 'package:schoolapp/repositories/firebase/teacher/db_functions_teacher.dart';

part 'teacher_second_event.dart';
part 'teacher_second_state.dart';

class TeacherSecondBloc extends Bloc<TeacherSecondEvent, TeacherSecondState> {
  String? id = '';
  TeacherSecondBloc() : super(TeacherSecondInitial()) {
    on<CheckBoxTapEvent>(checkBoxTapEvent);
    on<SubmitAttendanceEvent>(submitAttendanceEvent);
  }

  FutureOr<void> checkBoxTapEvent(
      CheckBoxTapEvent event, Emitter<TeacherSecondState> emit) {
    emit(CheckBoxTapState(isChecked: event.isChecked, index: event.index));
  }

  FutureOr<void> submitAttendanceEvent(
      SubmitAttendanceEvent event, Emitter<TeacherSecondState> emit) async {
    id = await DbFunctionsTeacher().getTeacherIdFromPrefs();
    emit(SubmitAttendanceLoadingState());
    try {
      final responce = await AttendenceFunctions()
          .submitAttendance(event.students, event.checkMarks, id as String);
      if (responce) {
        emit(SubmitAttendanceSuccessState());
      } else {
        emit(SubmitAttendanceErrorState());
      }
    } catch (e) {
      emit(SubmitAttendanceErrorState());
    }
  }
}
