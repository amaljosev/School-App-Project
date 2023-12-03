import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/firebase/student/db_functions_student.dart';
import 'package:schoolapp/repositories/firebase/student/tasks_functions.dart';
import 'package:schoolapp/repositories/firebase/teacher/db_functions_teacher.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<StudentBottomNavigationEvent>(bottomNavigationEvent);
    on<StudentActionsEvent>(studentActionsEvent);
    on<FetchStudentDataEvent>(fetchStudentDataEvent);
    on<FetchEventsDataEvent>(fetchEventsDataEvent);
    on<SubmitWorkEvent>(submitWorkEvent);
    on<LoadingEvent>(loadingEvent);
    on<FileUploadedEvent>(fileUploadedEvent);
  }

  FutureOr<void> bottomNavigationEvent(
      StudentBottomNavigationEvent event, Emitter<StudentState> emit) {
    emit(
        StudentBottomNavigationState(currentPageIndex: event.currentPageIndex));
  }

  FutureOr<void> studentActionsEvent(
      StudentActionsEvent event, Emitter<StudentState> emit) async {
    final teacherId = await DbFunctionsTeacher().getTeacherIdFromPrefs();
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherId)
        .collection('attendance')
        .get();
    final DocumentSnapshot classDoc = querySnapshot.docs.first;
    int totalWorkingDays = classDoc.get('toatal_working_days_completed');
    emit(StudentActionsState(
        index: event.index,
        name: event.name,
        studentsMap: event.studentsMap,
        totalWorkingDaysCompleted: totalWorkingDays));
  }

  FutureOr<void> fetchStudentDataEvent(
      FetchStudentDataEvent event, Emitter<StudentState> emit) async {
    final studentId = await DbFunctionsTeacher().getStudentIdFromPrefs();
    final teacherId = await DbFunctionsTeacher().getTeacherIdFromPrefs();
    final Stream<DocumentSnapshot<Object?>> studentstream = DbFunctionsStudent()
        .getStudentsDatas(teacherId as String, studentId as String);
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherId)
        .collection('attendance')
        .get();
    final DocumentSnapshot classDoc = querySnapshot.docs.first;
    int totalWorkingDays = classDoc.get('toatal_working_days_completed');
    emit(FetchStudentDatasSuccessState(
        studentstream: studentstream,
        studentId: studentId,
        totalWorkingDaysCompleted: totalWorkingDays));
  }

  FutureOr<void> fetchEventsDataEvent(
      FetchEventsDataEvent event, Emitter<StudentState> emit) async {
    emit(FetchEventsDatasLoadingState());
    try {
      final String? teacherId =
          await DbFunctionsTeacher().getTeacherIdFromPrefs();
      Stream<QuerySnapshot<Object?>> eventsStream = TasksDbFunctionsStudent()
          .getEventsDatas(teacherId: teacherId as String, collection: 'events');

      emit(FetchEventsDatasSuccessDatas(eventsData: eventsStream));
    } catch (e) {
      emit(FetchEventsDatasErrorState());
    }
  }

  FutureOr<void> submitWorkEvent(
      SubmitWorkEvent event, Emitter<StudentState> emit) async {
    emit(SubmitWorkLoadingState());
    try {
      final studentId =
          await DbFunctionsTeacher().getStudentIdFromPrefs() as String;
      final teacherId =
          await DbFunctionsTeacher().getTeacherIdFromPrefs() as String;
      final bool isHw = event.isHw;
      final bool resopnse = isHw
          ? await TasksDbFunctionsStudent().submitHomeWork(
              teacherId: teacherId,
              note: event.note,
              subject: event.subject,
              name: event.name,
              imageUrl: event.imageUrl,
              studentId: studentId)
          : await TasksDbFunctionsStudent().submitAssignment(
              teacherId: teacherId,
              note: event.note,
              subject: event.subject,
              name: event.name,
              imageUrl: event.imageUrl,
              studentId: studentId);
      if (resopnse) {
        emit(SubmitWorkSuccessState());
      } else {
        emit(SubmitWorkErrorState());
      }
    } catch (e) {
      emit(SubmitWorkErrorState());
    }
  }

  FutureOr<void> loadingEvent(LoadingEvent event, Emitter<StudentState> emit) {
    emit(LoadingState(isCompleted: event.isCompleted));
  }

  FutureOr<void> fileUploadedEvent(
      FileUploadedEvent event, Emitter<StudentState> emit) {
    emit(FileUploadedState(imageUrl: event.imageUrl));
  }
}
