part of 'teacher_bloc.dart';

abstract class TeacherState {}

abstract class TeacherActionState extends TeacherState {}

final class TeacherInitial extends TeacherState {}

final class HomeState extends TeacherActionState {}

final class FormStudentState extends TeacherActionState {}

final class AddStudentSuccessState extends TeacherActionState {}

final class AddStudentLoadingState extends TeacherActionState {}

final class AddStudentErrorState extends TeacherActionState {}

final class AttendenceState extends TeacherActionState {}

final class StudentProfileState extends TeacherActionState {
  final Map<String, dynamic> students;
  final String studentId;
  final CollectionReference<Map<String, dynamic>> studentFee;
  StudentProfileState(
      {required this.students,
      required this.studentFee,
      required this.studentId});
}

final class BottomNavigationState extends TeacherActionState {
  final int currentPageIndex;
  BottomNavigationState({required this.currentPageIndex});
}

final class SchoolEventsState extends TeacherActionState {}

final class TeacherAssignmetState extends TeacherActionState {}

final class TeacherHomeWorkState extends TeacherActionState {}

final class TeacherLeaveApplicationState extends TeacherActionState {}

final class FetchTeacherDataState extends TeacherActionState {
  Stream<DocumentSnapshot<Object?>>? teacherDatas;
  FetchTeacherDataState({required this.teacherDatas});
}

final class RadioButtonState extends TeacherActionState {
  final Gender? gender;
  RadioButtonState({required this.gender});
}

final class FetchStudentDatasState extends TeacherActionState {
  final Stream<QuerySnapshot<Object?>> studetDatas;
  FetchStudentDatasState({required this.studetDatas});
}

final class FetchClassDetailsState extends TeacherActionState {
  final Stream<QuerySnapshot<Object?>> classDatas;
  FetchClassDetailsState({required this.classDatas});
}

final class FetchClassDetailsErrorState extends TeacherActionState {}

final class FetchClassDetailsLoadingState extends TeacherActionState {}

final class UpdateFeeScreenState extends TeacherActionState {
  final Map<String, dynamic> feeData;
  final String studentId;
  UpdateFeeScreenState({required this.feeData, required this.studentId});
}

final class UpdateStudentFeeState extends TeacherActionState {}

final class UpdateStudentDataState extends TeacherActionState {}

final class FetchAllStudentsSuccessState extends TeacherActionState {
  final Stream<QuerySnapshot<Object?>> studentDatas;
  FetchAllStudentsSuccessState({required this.studentDatas});
}

final class FetchAllStudentsErrorState extends TeacherActionState {}

final class FetchAllStudentsLoadingState extends TeacherActionState {}
