class StudentModel {
  final int rollNo; 
  final String name;
  final int age;
  final int className;
  final int registerNo;
  final String email;
  final int contactNo;
  final String guardianName;
  final String password;

  StudentModel(
      {required this.rollNo,
      required this.name,
      required this.age,
      required this.className,
      required this.registerNo,
      required this.email,
      required this.contactNo,
      required this.guardianName,
      required this.password});
}
