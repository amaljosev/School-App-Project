class AttendanceModel {
  final int totalWorkingDaysCompleted;
  final int todayPresents;
  final int todayAbsents;

  AttendanceModel(
      {required this.totalWorkingDaysCompleted,
      required this.todayPresents,
      required this.todayAbsents});
}
