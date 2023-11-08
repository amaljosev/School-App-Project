part of 'teacher_bloc.dart';

abstract class TeacherState {}

abstract class TeacherActionState extends TeacherState {}

final class TeacherInitial extends TeacherState {}

final class HomeState extends TeacherActionState {}

final class FormStudentState extends TeacherActionState {}

final class AddStudentState extends TeacherActionState {}

final class AttendenceState extends TeacherActionState {}

final class StudentProfileState extends TeacherActionState {}

final class BottomNavigationState extends  TeacherActionState{ 
 final int currentPageIndex;
 BottomNavigationState({required this.currentPageIndex});
}

final class SchoolEventsState extends TeacherActionState {} 

final class TeacherAssignmetState extends TeacherActionState{}

final class TeacherHomeWorkState extends TeacherActionState{}

final class TeacherLeaveApplicationState extends TeacherActionState{} 