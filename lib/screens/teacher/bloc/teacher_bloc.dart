import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/models/student_model.dart';
import 'package:schoolapp/repositories/firebase/teacher/add_student_functions.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  TeacherBloc() : super(TeacherInitial()) {
    on<TeacherEvent>(teacherEvent);
    on<FormStudentEvent>(formStudentEvent);
    on<AddStudentEvent>(addStudentEvent);
    on<AttendenceEvent>(attendenceEvent);
    on<StudentProfileEvent>(studentProfileEvent);
    on<BottomNavigationEvent>(bottomNavigationEvent);
    on<SchoolEventsEvent>(schoolEventsEvent);
  }

  FutureOr<void> formStudentEvent(
      FormStudentEvent event, Emitter<TeacherState> emit) {
    emit(FormStudentState());
  }

  FutureOr<void> addStudentEvent(
      AddStudentEvent event, Emitter<TeacherState> emit) {
    StudentDbFunctions().addStudent(event.studentData);
    emit(AddStudentState());
  }

  FutureOr<void> attendenceEvent(
      AttendenceEvent event, Emitter<TeacherState> emit) {
    emit(AttendenceState());
  }

  FutureOr<void> studentProfileEvent(
      StudentProfileEvent event, Emitter<TeacherState> emit) {
    emit(StudentProfileState());
  }

  FutureOr<void> bottomNavigationEvent(
      BottomNavigationEvent event, Emitter<TeacherState> emit) {
    emit(BottomNavigationState(currentPageIndex: event.currentPageIndex));
  }

  FutureOr<void> teacherEvent(TeacherEvent event, Emitter<TeacherState> emit) {
    emit(HomeState());
  }

  FutureOr<void> schoolEventsEvent(SchoolEventsEvent event, Emitter<TeacherState> emit) { 
    emit(SchoolEventsState()); 
  }
}
