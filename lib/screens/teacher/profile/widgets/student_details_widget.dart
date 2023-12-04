import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/constants.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/teacher/form/newstudent_form.dart';

class StudentDetailsWidget extends StatelessWidget {
  const StudentDetailsWidget({
    super.key,
    required this.isTeacher,
    required this.students,
    required this.studentId,
  });
  final bool isTeacher;
  final Map<String, dynamic> students;
  final String studentId;
  @override
  Widget build(BuildContext context) {
    final studentName = "${students['first_name']} ${students['second_name']}";
    return Padding(
      padding: isTeacher
          ? const EdgeInsets.all(8)
          : const EdgeInsets.only(top: 15.0),
      child: Container(
        height: isTeacher ? 280 : 250,
        width: double.infinity,
        decoration: BoxDecoration(
            color: isTeacher ? appbarColor : null,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  isTeacher ? MainAxisAlignment.end : MainAxisAlignment.center,
              children: [
                Text(isTeacher ? "" : studentName.toUpperCase(),
                    style: appbarTextStyle),
                isTeacher
                    ? TextButton.icon(
                        label: const Text('Edit'),
                        icon: const Icon(Icons.settings_suggest_outlined),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScreenStudentForm(
                                  isUpdate: true,
                                  students: students,
                                  studentId: studentId,
                                  isTeacher: isTeacher),
                            )),
                      )
                    : const SizedBox()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    Text("RollNo ", style: studentProfileTextStyle),
                    kHeight, 
                    Text('Class Teacher ', style: studentProfileTextStyle),
                     kHeight, 
                    Text('Age ', style: studentProfileTextStyle),

                     kHeight, 
                    Text('Class ', style: studentProfileTextStyle),
                     kHeight, 
                    Text('RegisterNo ', style: studentProfileTextStyle),
                     kHeight, 
                    Text('ContactNo ', style: studentProfileTextStyle),
                     kHeight, 
                    Text('Guardian Name ', style: studentProfileTextStyle),
                     kHeight, 
                    Text('Email ', style: studentProfileTextStyle),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(": ${students['roll_no']}",
                        style: studentProfileTextStyle), kHeight,  
                    Text(": ${students['class_Teacher']}",
                        style: studentProfileTextStyle), kHeight, 
                    Text(": ${students['age']} ",
                        style: studentProfileTextStyle), kHeight, 
                    Text(": ${students['standard']}-${students['division']}",
                        style: studentProfileTextStyle), kHeight, 
                    Text(": ${students['register_no']} ",
                        style: studentProfileTextStyle), kHeight, 
                    Text(": ${students['contact_no']} ",
                        style: studentProfileTextStyle), kHeight, 
                    Text(": ${students['guardian_name']} ",
                        style: studentProfileTextStyle), kHeight, 
                    Text(": ${students['email']} ",
                        style: studentProfileTextStyle),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
