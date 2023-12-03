part of 'student_bloc.dart';

abstract class StudentEvent {}

abstract class StudentActionEvent extends StudentEvent {}

final class StudentBottomNavigationEvent extends StudentActionEvent {
  final int currentPageIndex;
  StudentBottomNavigationEvent({required this.currentPageIndex});
}

final class StudentActionsEvent extends StudentActionEvent {
  final int index;
  final String name;
  StudentActionsEvent({required this.index, required this.name});
}

final class FetchStudentDataEvent extends StudentActionEvent {}

final class FetchEventsDataEvent extends StudentActionEvent {}

final class SubmitWorkEvent extends StudentActionEvent {
  final String subject;
  final String note;
  final String name;
  final bool isHw;
  final String imageUrl;
  SubmitWorkEvent(
      {required this.subject,
      required this.note,
      required this.name,
      required this.isHw,
      required this.imageUrl});
}

final class LoadingEvent extends StudentActionEvent {
  final bool isCompleted;
  LoadingEvent({required this.isCompleted});
}

final class FileUploadedEvent extends StudentActionEvent {
  final String imageUrl;
  FileUploadedEvent({required this.imageUrl});
}
