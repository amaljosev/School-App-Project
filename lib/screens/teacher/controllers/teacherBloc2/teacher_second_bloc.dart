import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/firebase/teacher/attendance_functions.dart';
import 'package:schoolapp/repositories/firebase/teacher/db_functions_teacher.dart';
import 'package:schoolapp/repositories/firebase/teacher/task_db_functions.dart';

part 'teacher_second_event.dart';
part 'teacher_second_state.dart';

class TeacherSecondBloc extends Bloc<TeacherSecondEvent, TeacherSecondState> {
  String? id = '';
  TeacherSecondBloc() : super(TeacherSecondInitial()) {
    on<CheckBoxTapEvent>(checkBoxTapEvent);
    on<SubmitAttendanceEvent>(submitAttendanceEvent);
    on<FetchAttendanceHistoryEvent>(fetchAttendanceHistoryEvent);
    on<HomeWorkSendEvent>(homeWorkSendEvent);
    on<TaskDropDownEvent>(taskDropDownEvent);
    on<DateSelectedEvent>(dateSelectedEvent);

    on<AssignmentSendEvent>(assignmentSendEvent);
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

  FutureOr<void> fetchAttendanceHistoryEvent(FetchAttendanceHistoryEvent event,
      Emitter<TeacherSecondState> emit) async {
    emit(FetchAttendanceHistoryLoadingState());
    try {
      id = await DbFunctionsTeacher().getTeacherIdFromPrefs();
      final attendanceHistory = DbFunctionsTeacher().getAttendanceHistory(id);
      emit(FetchAttendanceHistorySuccessState(
          attendenceHistory: attendanceHistory));
    } catch (e) {
      emit(FetchAttendanceHistoryErrorState());
    }
  }

  FutureOr<void> homeWorkSendEvent(
      HomeWorkSendEvent event, Emitter<TeacherSecondState> emit) async {
    emit(HomeWorkSendLoadingState());
    try {
      id = await DbFunctionsTeacher().getTeacherIdFromPrefs();
      final bool responce = await TaskTeacherDbFunctions()
          .addHomeWork(id as String, event.task, event.subject);
      if (responce) {
        emit(HomeWorkSendSuccessState());
      } else {
        emit(HomeWorkSendErrorState());
      }
    } catch (e) {
      emit(HomeWorkSendErrorState());
    }
  }

  FutureOr<void> taskDropDownEvent(
      TaskDropDownEvent event, Emitter<TeacherSecondState> emit) {
    emit(HomeWorkDropDownState(index: event.index, value: event.value));
  }

  FutureOr<void> assignmentSendEvent(
      AssignmentSendEvent event, Emitter<TeacherSecondState> emit) async {
    emit(AssignmentSendLoadingState());
    try {
      id = await DbFunctionsTeacher().getTeacherIdFromPrefs();
      final bool responce = await TaskTeacherDbFunctions().addAssignments(
          id as String, event.task, event.subject, event.selectedDate);
      if (responce) {
        emit(AssignmentSendSuccessState());
      } else {
        emit(AssignmentSendErrorState());
      }
    } catch (e) {
      emit(AssignmentSendErrorState());
    }
  }

  FutureOr<void> dateSelectedEvent( 
      DateSelectedEvent event, Emitter<TeacherSecondState> emit) {
    emit(DateSelectedState(selectedDate: event.selectedDate));
  }
}
