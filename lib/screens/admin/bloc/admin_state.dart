part of 'admin_bloc.dart';

abstract class AdminState {}

abstract class AdminActionState extends AdminState {}

final class AdminInitial extends AdminState {}

final class StudentCardTapState extends AdminActionState {
  final Stream<QuerySnapshot> studentList;
  final String standard;
  StudentCardTapState({required this.studentList, required this.standard});
}

final class TeacherCardTapState extends AdminActionState {
  final Map<String, dynamic> teacherData;

  TeacherCardTapState({required this.teacherData});
}

final class RequestTapState extends AdminActionState {}

final class LogOutState extends AdminActionState {}

final class SettingsState extends AdminActionState {}

final class ShowWarningPopUpState extends AdminActionState {}

final class CheckboxSelectedState extends AdminActionState {
  final bool? isSelected;
  CheckboxSelectedState({required this.isSelected});
}

final class AcadamicYearUpdateSuccessState extends AdminActionState {}

final class AcadamicYearUpdateErrorState extends AdminActionState {}

final class AcadamicYearUpdateLoadingState extends AdminActionState {}
