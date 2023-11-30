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
  }

  FutureOr<void> bottomNavigationEvent(
      StudentBottomNavigationEvent event, Emitter<StudentState> emit) {
    emit(
        StudentBottomNavigationState(currentPageIndex: event.currentPageIndex));
  }

  FutureOr<void> studentActionsEvent(
      StudentActionsEvent event, Emitter<StudentState> emit) {
    emit(StudentActionsState(index: event.index));
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
}
