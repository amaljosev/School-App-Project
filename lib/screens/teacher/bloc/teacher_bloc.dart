import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/models/student_model.dart';
import 'package:schoolapp/repositories/firebase/teacher/add_student_functions.dart';
import 'package:schoolapp/repositories/firebase/teacher/db_functions_teacher.dart';
import 'package:schoolapp/screens/teacher/form/newstudent_form.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  String? id = '';
  TeacherBloc() : super(TeacherInitial()) {
    on<TeacherEvent>(teacherEvent);
    on<FormStudentEvent>(formStudentEvent);
    on<AddStudentEvent>(addStudentEvent);
    on<AttendenceEvent>(attendenceEvent);
    on<StudentProfileEvent>(studentProfileEvent);
    on<BottomNavigationEvent>(bottomNavigationEvent);
    on<SchoolEventsEvent>(schoolEventsEvent);
    on<TeacherAssignmentEvent>(teacherAssignmentEvent);
    on<TeacherLeaveApplicationEvent>(teacherLeaveApplicationEvent);
    on<TeacherHomeWorkEvent>(teacherHomeWorkEvent);
    on<FetchTeacherDatasEvent>(fetchTeacherDatasEvent);
    on<DropdownTeacherEvent>(dropdownTeacherEvent);
    on<RadioButtonEvent>(radioButtonEvent);
    on<FetchStudentDatasEvent>(fetchStudentDatasEvent);
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
    emit(StudentProfileState(students: event.students,index: event.index));  
  }

  FutureOr<void> bottomNavigationEvent(
      BottomNavigationEvent event, Emitter<TeacherState> emit) {
    emit(BottomNavigationState(currentPageIndex: event.currentPageIndex));
  }

  FutureOr<void> teacherEvent(TeacherEvent event, Emitter<TeacherState> emit) {
    emit(HomeState());
  }

  FutureOr<void> schoolEventsEvent(
      SchoolEventsEvent event, Emitter<TeacherState> emit) {
    emit(SchoolEventsState());
  }

  FutureOr<void> teacherAssignmentEvent(
      TeacherAssignmentEvent event, Emitter<TeacherState> emit) {
    emit(TeacherAssignmetState());
  }

  FutureOr<void> teacherLeaveApplicationEvent(
      TeacherLeaveApplicationEvent event, Emitter<TeacherState> emit) {
    emit(TeacherLeaveApplicationState());
  }

  FutureOr<void> teacherHomeWorkEvent(
      TeacherHomeWorkEvent event, Emitter<TeacherState> emit) {
    emit(TeacherHomeWorkState());
  }

  FutureOr<void> fetchTeacherDatasEvent(
      FetchTeacherDatasEvent event, Emitter<TeacherState> emit) async {
    id = await DbFunctionsTeacher().getTeacherIdFromPrefs();
    Stream<DocumentSnapshot<Object?>>? teacherDatas =
        DbFunctionsTeacher().getTeacherData(id as String);
    emit(FetchTeacherDataState(teacherDatas: teacherDatas));
  }

  FutureOr<void> dropdownTeacherEvent(
      DropdownTeacherEvent event, Emitter<TeacherState> emit) {
    emit(DropdownTeacherState(
        dropdownValue: event.dropdownValue, index: event.onSelected));
  }

  FutureOr<void> radioButtonEvent(
      RadioButtonEvent event, Emitter<TeacherState> emit) {
    emit(RadioButtonState(gender: event.gender));
  }

  FutureOr<void> fetchStudentDatasEvent(
      FetchStudentDatasEvent event, Emitter<TeacherState> emit) async {
    id = await DbFunctionsTeacher().getTeacherIdFromPrefs();
    Stream<QuerySnapshot<Object?>>? studentDatas =
        DbFunctionsTeacher().getStudentsDatas(id);
    emit(FetchStudentDatasState(studetDatas: studentDatas));
  }
}
