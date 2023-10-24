class TeacherModel {
  final String name;
  final int className;
  final String email;
  final int contact;
  final String password;
  final String students;

  TeacherModel(
      {required this.students,
      required this.name,
      required this.className,
      required this.email,
      required this.contact,
      required this.password});
}
