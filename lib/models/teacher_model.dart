class TeacherModel {
  final String name;
  final String classId;
  final String className;
  final String email;
  final int contact;
  final String password;
  final String students;

  TeacherModel(
      {required this.name,
      required this.classId,
      required this.className,
      required this.email,
      required this.contact,
      required this.password,
      required this.students});
}
